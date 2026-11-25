---
layout: default
title: How-To Submit a GPU Job
parent: Slurm
nav_order: 7
---

# How-To Submit a GPU Job

To run on a GPU, you need to do two things in your job script:

1. Specify a partition containing GPU-equipped compute nodes (for example `gpu` or `gpulong`; see the [Partition List]({% link docs/about_talapas/partition_list.md %})).
2. Reserve some number of GPUs for your job, for example with `--gpus=1`.

Optionally, you can also pick a GPU type or memory size (see [GPU types](#gpu-types) below) and tell your program which GPU it was given.

Run `/packages/racs/bin/slurm-show-gpus` to see how many GPUs each node has and what kinds they are.

## Example job script

Suppose we only need one GPU for our simulation. Our job script might look like this:

```bash
#!/bin/bash

#SBATCH --account=<pirg>          ### your slurm account is the name of your pirg
#SBATCH --partition=gpu           ### partition containing GPU nodes, see Partition List
#SBATCH --job-name=GPUjob         ### name of your job
#SBATCH --output=GPUjob.out       ### name of batch script's standard output
#SBATCH --error=GPUjob.err        ### name of batch script's standard error
#SBATCH --time=1-00:00:00         ### wall clock time limit in Days-HH:MM:SS
#SBATCH --nodes=1                 ### request 1 node
#SBATCH --ntasks-per-node=1       ### number of tasks to be launched per node
#SBATCH --cpus-per-task=1         ### number of cpus per task
#SBATCH --mem=8G                  ### memory for the job on the node
#SBATCH --gpus=1                  ### total number of GPUs for the job

module load cuda/12.4.1

nvidia-smi                        ### list the GPU(s) assigned to this job

./my_executable
```

Submit it with `sbatch gpu_job.sbatch`.

{: .note }
Request GPUs with `--gpus` (total for the job), `--gpus-per-node` or `--gpus-per-task`. You can also use the older `--gres=gpu:<count>` form (equivalent to `--gpus-per-node=<count>`); pick one style and use it consistently in your script. If you need all of your GPUs on a single node, also specify `--nodes=1`.

Check the current CUDA versions with `module avail cuda`. At the time of writing they are `11.8.0`, `12.4.1` and `13.0`; see the [Packages]({% link docs/software/packages.md %}) list.

## Which GPU did I get?

Slurm sets the environment variable `CUDA_VISIBLE_DEVICES` for your job to the GPU(s) assigned to it, and CUDA programs honor it automatically, so most programs need no extra configuration. The numbering starts at 0 within your job, regardless of which physical GPU on the node you were given.

If your program needs the GPU index as an argument, pass it `$CUDA_VISIBLE_DEVICES` (for one GPU this is a single number such as `0`; for two it looks like `0,1`):

```bash
./my_executable $CUDA_VISIBLE_DEVICES
```

{: .note }
Slurm also sets `SLURM_JOB_GPUS` in batch and interactive jobs, but it holds the _global_ GPU IDs on the node, which are not renumbered from 0 for your job, so it can differ from `CUDA_VISIBLE_DEVICES`. Inside job steps launched with `srun`, Slurm sets `SLURM_STEP_GPUS` (global IDs, again) instead. `CUDA_VISIBLE_DEVICES` is set for each job step. (Unverified on Talapas; please report anything different to RACS.)

## GPU types

Currently, the `gpu` and `gpulong` partitions contain only NVIDIA A100 GPUs, so you don't need to explicitly specify a GPU type. Most other partitions also contain only one kind of GPU.

A100s support "Multi-Instance GPU" (MIG) slicing, which splits one card into multiple "virtual GPUs", each with a share of the card's memory. On Talapas, slices with 10, 40 and 80 GB of GPU memory are available. To choose the amount, add a constraint to your script, using ONE of `gpu-10gb`, `gpu-40gb` or `gpu-80gb`:

```bash
#SBATCH --constraint=gpu-40gb
```

The notable exception is the `preempt` partition, which contains most Talapas nodes and many kinds of GPUs. The easiest way to see the available types is to run `/packages/racs/bin/slurm-show-gpus`.

You can also use node features (with the `--constraint` flag) to limit your job to a particular GPU card type, if it is available in your partition, by using the card's feature tag, for example `a100`, `l40s`, `a40`, `v100` or `h100`. See the available node features by running `/packages/racs/bin/slurm-show-features`.

## See also

* [How-To Start an Interactive Job]({% link docs/slurm/how-to_start_an_interactive_job.md %}) (includes interactive GPU jobs)
* [How-To Use the preempt Partition]({% link docs/slurm/how-to_use_the_preempt_partition.md %})
* [How-To Submit a Batch Job]({% link docs/slurm/how-to_submit_a_batch_job.md %})
