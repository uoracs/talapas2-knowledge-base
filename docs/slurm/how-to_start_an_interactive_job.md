---
layout: default
title: How-To Start An Interactive Job
parent: Slurm
nav_order: 8
---

# How-To Start An Interactive Job

When you want to work interactively on a compute node, start an interactive job with `srun`. Remember that login nodes are not for running applications; use an interactive job instead.

From a login node, invoke

```bash
$ srun --account=<pirg> --partition=interactive --pty bash
```

This will launch a job on the `interactive` partition and give you a shell on the assigned compute node. Slurm requires an account, and there is no default partition, so you must specify both. See the [Partition List]({% link docs/about_talapas/partition_list.md %}) for the available partitions.

Optionally, you may pass any of the regular job options to `srun`, such as the amount of memory or the number of CPUs. For example, to launch a job on the `compute` partition we would invoke

```bash
$ srun --account=<pirg> --partition=compute --pty bash
```

For a full list of options see `man srun`.

Note that, as with batch jobs, if there are no slots available in the partition you choose, the `srun` command will wait until one becomes available and then proceed. So, if the command seems to hang, this is probably what is happening.

If you know that you'll only need your interactive shell for a relatively short time (less than 24h), you might want to use the `--time` flag to specify a shorter time, which will increase the chance that it will be scheduled immediately.

For example, launch a job with a time limit of 90 minutes,

```bash
$ srun --account=<pirg> --partition=interactive --pty --time=90 bash
```

After 90 minutes, if you don't exit sooner, the job will be killed and you will be disconnected from the compute node.

When you are done, type `exit` to end the job and release the resources.

## Running Interactive GPU jobs

Interactive jobs are not limited to CPU only jobs, you can also use GPUs when submitting an interactive job.

In order to do this, you'll need to request a GPU. An example of this is seen below:

```bash
$ srun --account=<pirg> --partition=interactivegpu --time=20 --nodes=1 --ntasks=1 --cpus-per-task=1 --mem=500M --gpus=1 --constraint=gpu-10gb --pty bash
```

`srun` → Submits and runs a job interactively in Slurm.

`--account=<pirg>` → Specifies the PIRG that the job will run under (this is the PIRG you are part of).

`--partition=interactivegpu` → Requests the `interactivegpu` partition, which is meant for shorter interactive GPU jobs.

`--time=20` → Sets a time limit of 20 minutes for the job. The default is 1 hour and a max of 12 hours.

`--nodes=1` → Requests 1 compute node.

`--ntasks=1` → Specifies 1 task for the job (useful for MPI workloads, but here it just means one job instance).

`--cpus-per-task=1` → Allocates 1 CPU core per task.

`--mem=500M` → Requests 500 MB of RAM.

`--gpus=1` → Requests 1 GPU for the job.

`--constraint=gpu-10gb` → Requests a GPU with 10GB of memory. Nodes in the `interactivegpu` partition only have GPUs with 10GB memory, so in this case you don't have to specify it. However, other GPU nodes on Talapas have 10, 40, and 80 GB of GPU memory and are requested with `gpu-10gb`, `gpu-40gb`, and `gpu-80gb`.

`--pty` → Runs the command in a pseudo-terminal (interactive session).

`bash` → Starts a Bash shell in the allocated environment.

## See also

- [How-To Submit a Batch Job]({% link docs/slurm/how-to_submit_a_batch_job.md %})
- [How-To Submit a GPU Job]({% link docs/slurm/how-to_submit_a_gpu_job.md %})
- [Quick Start Guide]({% link docs/quickstart_guide/quickstart_guide.md %}) (including graphical interactive jobs)
