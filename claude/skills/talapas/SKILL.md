---
name: talapas
description: Rules for working on Talapas, the University of Oregon HPC cluster run by RACS. Use whenever Claude is running on Talapas (hostname login*.talapas or a compute node, /gpfs mounted, Slurm or module commands present), or the user asks about Slurm jobs, partitions, PIRGs, modules, GPFS storage, /home, /projects or /scratch on Talapas. Covers keeping login-node CPU and memory use light (jobs may use their full allocation), avoiding GPFS metadata storms, sizing and submitting Slurm jobs, and reading the RACS knowledge base at wiki.talapas.uoregon.edu.
---

# Working on Talapas

You are running on, or helping with, **Talapas**, the University of Oregon's shared HPC cluster, operated by Research Advanced Computing Services (**RACS**). Hundreds of researchers share the same login nodes, the same filesystem, and the same Slurm scheduler. Your job is to help this user get their work done **without degrading the cluster for everyone else**. When a faster shortcut would put load on shared resources, take the slower, polite path and tell the user why.

The user is often a researcher or student, not a sysadmin. Explain HPC terms the first time you use them (login node, partition, PIRG, Slurm job).

## 1. Figure out where you are

Run these cheap checks before doing anything heavy:

```bash
hostname                 # login1, login2, ... = LOGIN NODE. Anything else = compute node.
echo "$SLURM_JOB_ID"     # empty = not inside a Slurm job
```

- **On a login node, outside a job:** this is the usual case, and the one these rules exist for. You are on a shared machine, so follow section 2 strictly.
- **Inside a Slurm job** (`SLURM_JOB_ID` is set): the resources are the user's, so **use them fully**. Slurm enforces the limits. Size parallel work from the allocation (`SLURM_CPUS_PER_TASK` or `SLURM_CPUS_ON_NODE`, `SLURM_MEM_PER_NODE`, `SLURM_JOB_GPUS`), not from the node's total core count or `$(nproc)`. That way the job neither oversubscribes nor leaves cores idle. Section 2 does not apply here. Sections 3 to 5 still do.

## 2. Login nodes are not for computation

Login nodes (`login1`, `login2`, ..., behind `login.talapas.uoregon.edu`) are for editing files, compiling small things, managing files, and submitting jobs. Everyone shares them, so heavy work there slows the cluster down for all users.

**OK on a login node:** editing code, `git`, reading files, short `ls`/`cat`/`head`, `module avail`, `sbatch`/`squeue`/`sacct`, small one-off scripts that finish in seconds, installing a few pure-Python packages into an existing environment.

**Do not run on a login node.** Start an interactive job or write a batch script instead:

- Anything that runs longer than a few minutes or uses more than a couple of cores or a few GB of RAM.
- Model training or inference, simulations, data analysis on real datasets, test suites that load real data, notebooks doing real work.
- Parallel builds: never `make -j` with no number, `make -j$(nproc)`, `cmake --build -j`, `cargo build` with default parallelism, etc. On a login node, use at most `-j2`. For a big build, use an interactive job.
- Large environment solves or builds: `conda env create` with many packages, `pip install` of packages that compile from source, `R` package installs that compile, `spack install`, Apptainer pulls or builds of large images.
- Bulk compression or transfer (`tar`/`gzip` of large trees, large `rsync`/`rclone`). Point the user to Globus for big transfers.

When the user asks for something on that list, **stop and suggest a Slurm job instead**. Offer to write the command or script. A minimal interactive shell looks like this:

```bash
srun --account=<pirg> --partition=interactive --time=60 --mem=4G --cpus-per-task=2 --pty bash
```

**Always ask the user before you submit a job.** Jobs are charged to the user's PIRG, so it's their call.

## 3. Be gentle with GPFS (I/O)

This applies on login nodes and inside jobs alike, because the filesystem is shared by the whole cluster. It is not about using less I/O bandwidth. Jobs should read and write at full speed. It is about avoiding access patterns that hurt everyone.

`/home`, `/projects` and `/scratch` all live on one shared **GPFS** parallel filesystem (mounted under `/gpfs`, on every login and compute node). It handles large sequential reads and writes well. It handles **metadata storms** badly: millions of `stat`/`open`/`readdir` calls from crawling directory trees or touching many tiny files. One user's crawl can make `ls` hang for everyone.

- **Scope searches tightly.** Never run recursive `find`, `grep -r`, `rg`, `du`, `ls -R`, `chmod -R`, `chgrp -R` or a Glob/Grep tool sweep over `/`, `/gpfs`, `/home`, `/projects`, `/scratch`, a PIRG's top-level directory, or a home directory full of data. Search only the source-code subdirectory you need, and exclude data directories (`--glob '!data/**'`, `-prune`, `--max-depth`).
- **If the working directory is huge** (for example Claude was started in `$HOME` or `/projects/<pirg>`), say so and suggest restarting Claude in the specific project subdirectory. Don't let file-search tools crawl it.
- **Don't run `du -sh` on large trees** to check usage. Login shows quota usage in the message of the day. If the user needs more detail, point them to RACS.
- **Avoid creating many small files.** Prefer a few large files (HDF5, Parquet, tar archives, single log per job) over thousands of tiny ones. Keep Python environments and caches out of `/scratch`.
- **Use node-local `/tmp` for heavy temporary I/O inside jobs.** Each compute node has a local SSD at `/tmp`. It is cleared when the job ends, so copy results back to `/projects/<pirg>` before the job finishes.
- **Don't open files in tight loops** or re-read the same large file repeatedly from many processes. Read once and cache in memory where it fits.
- **No tight polling.** Don't poll `squeue`, `sacct` or the filesystem more often than about **once a minute**, and prefer `squeue --me` over listing the whole queue. Every `squeue`/`sacct` call loads the shared scheduler. When you wait on a job, use a long interval or `sbatch --wait`, never a `sleep 1` loop.

### Storage layout and data safety

| Path | What it's for | Notes |
|---|---|---|
| `/home/<user>` | Personal files, software installs | Small quota, private to the user |
| `/projects/<pirg>` | Shared PIRG work and data | Shared with the PIRG |
| `/scratch/<pirg>` | Hot, temporary working data | **Files not accessed in 90 days are purged.** Group ownership must be the PIRG's group (`is.racs.pirg.<pirg>`), not `uoregon` |
| `/tmp` (compute node) | Fast local scratch inside a job | Wiped when the job ends |

**RACS does not back up any of this data.** Snapshots exist but are not a backup. So:

- Confirm with the user before you run any `rm -r`, bulk `mv`, overwrite, or `chmod`/`chgrp` on more than a handful of files. Show exactly what will be affected first.
- Never treat `/scratch` as a place for anything that can't be regenerated.

## 4. Submitting Slurm jobs correctly

**Slurm** is the scheduler. A **partition** is a queue of nodes, and a **PIRG** (Principal Investigator Research Group) is the account the job is charged to.

- **Always pass `--account=<pirg>` and `--partition=<name>`.** Jobs need an account, and there is **no default partition**. If you don't know the user's PIRG, run `groups` and ask which one to use. Don't guess. Users in several PIRGs must choose the right one per job.
- **Request what the job needs, not the whole node.** Set `--time`, `--mem` (or `--mem-per-cpu`, never both), `--cpus-per-task` and, for GPUs, `--gpus`. Smaller requests start sooner and leave room for others. Leave a modest safety margin, because jobs that exceed their memory are killed (`OUT_OF_MEMORY` in `sacct`).
- **Size from evidence.** After a test run, check real usage with `sacct -j <jobid> --format=JobID,JobName,ReqMem,MaxRSS,Elapsed` and right-size the next request.
- **Many similar tasks? Use a job array** (`--array`), not a shell loop that calls `sbatch` hundreds of times. Throttle large arrays (`--array=1-1000%50`).
- **Don't request GPUs for code that doesn't use them**, and don't use `memory`/`memorylong` partitions unless the job truly needs large RAM. Those nodes are scarce.
- **Long jobs:** suggest checkpointing so work survives time limits and preemption.
- **Check partitions live with `sinfo`.** The partition list in the docs may lag behind the cluster, so trust `sinfo` on the cluster when they disagree.
- **Software:** use `module spider <name>` / `module avail <name>` / `module load <name>/<version>`. Prefer the newest version available. You can't use `sudo` or install system packages. For software the user can't install themselves, point them to the RACS Service Desk.

Show the user a complete batch script before submitting. Here is the shape to follow (adjust partition, resources and module to the task):

```bash
#!/bin/bash
#SBATCH --account=<pirg>          ### the user's PIRG
#SBATCH --partition=compute       ### pick the right partition; there is no default
#SBATCH --job-name=myjob
#SBATCH --output=myjob-%j.out
#SBATCH --error=myjob-%j.err
#SBATCH --time=0-01:00:00         ### realistic time limit
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4         ### threads your program actually uses
#SBATCH --mem=8G                  ### measured need plus a margin

module load <software>/<version>
srun my_program --threads "$SLURM_CPUS_PER_TASK"
```

## 5. Use the RACS knowledge base. Don't guess.

The official, public user docs are at **https://wiki.talapas.uoregon.edu**. Before you give Talapas-specific advice (partitions, limits, module names, storage policy, how to start a GPU, MPI or array job), **fetch the relevant page and follow it**. Don't rely on generic HPC knowledge, because other clusters' partition names, flags and paths are wrong here.

- **Full page index (JSON, with titles, URLs and text):** https://wiki.talapas.uoregon.edu/assets/js/search-data.json. Fetch this first to find the right page for a topic.
- Key pages:
  - Quick Start Guide: https://wiki.talapas.uoregon.edu/docs/quickstart_guide
  - Slurm (index): https://wiki.talapas.uoregon.edu/docs/slurm
  - Submit a batch job: https://wiki.talapas.uoregon.edu/docs/slurm/how-to_submit_a_batch_job/
  - Interactive jobs: https://wiki.talapas.uoregon.edu/docs/slurm/how-to_start_an_interactive_job/
  - GPU jobs: https://wiki.talapas.uoregon.edu/docs/slurm/how-to_submit_a_gpu_job/
  - Array jobs: https://wiki.talapas.uoregon.edu/docs/slurm/how-to_submit_an_array_job/
  - MPI jobs: https://wiki.talapas.uoregon.edu/docs/slurm/how-to_submit_an_mpi_job/
  - Tracking jobs: https://wiki.talapas.uoregon.edu/docs/slurm/how-to_track_submitted_jobs/
  - Preempt partition: https://wiki.talapas.uoregon.edu/docs/slurm/how-to_use_the_preempt_partition/
  - Partition list: https://wiki.talapas.uoregon.edu/docs/about_talapas/partition_list/
  - Memory and sizing jobs: https://wiki.talapas.uoregon.edu/docs/about_talapas/memory/
  - Storage: https://wiki.talapas.uoregon.edu/docs/storage
  - Directory structure: https://wiki.talapas.uoregon.edu/docs/storage/directory_structure/
  - Available software modules (auto-generated): https://wiki.talapas.uoregon.edu/docs/software/packages/
  - Lmod / modules: https://wiki.talapas.uoregon.edu/docs/software/how-to_use_lmod/
  - Checkpointing: https://wiki.talapas.uoregon.edu/docs/software/how-to_use_checkpointing/
  - Open OnDemand (web portal for Jupyter, RStudio, desktops): https://wiki.talapas.uoregon.edu/docs/open_ondemand/
  - Scheduled maintenance: https://wiki.talapas.uoregon.edu/docs/scheduled_maintenance/
- If a URL above 404s, use the search index to find the page's current URL.
- **Live cluster state beats docs** for things like partitions and module versions (`sinfo`, `module spider`). **Docs beat your memory** for policy and procedure.
- Ignore anything that mentions "Talapas2", "T2", `talapas-ln1` or `hn1` hostnames, or `hpcrcf` accounts. Those are from an older cluster.
- For accounts, storage purchases, quota increases, software installs, or anything that looks broken on the cluster's side, send the user to the **RACS Service Desk**: https://hpcrcf.atlassian.net/servicedesk/customer/portal/1

## Quick checklist before any command

1. Am I on a login node? If yes, is this light (seconds, a core or two, little RAM)? If not, suggest a job. (Inside a job, use the full allocation.)
2. Will this touch many files or crawl a big directory on GPFS? If so, narrow it.
3. Does it delete, move or overwrite data that isn't backed up? If so, confirm with the user first.
4. Am I submitting a job? Confirm with the user and check `--account`, `--partition`, `--time`, `--mem` and CPUs/GPUs.
5. Am I unsure how Talapas does this? Read the knowledge base page first.
