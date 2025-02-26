---
layout: default
title: How-To Start An Interactive Job
parent: How-To Articles
nav_order: 8
---

# How-To Start An Interactive Job

When you want to work interactively on a compute node

From a login node, invoke,

`srun --account=<myPIRG> --pty` `bash`

This will launch a job on the default partition and ssh you to the assigned node.

Optionally, you may pass any of the regular job options to `srun`. If you wish to specify the partition on which you wish to run, the amount of memory, etc.

For example, to launch a job on the "foo" partition we would invoke,

`srun --account=<myPIRG> --partition=foo --pty` `bash`

For a full list of options see `man srun`

Note that, as with batch jobs, if there are no slots available in the partition you choose, the `srun` command will wait until one becomes available and then proceed. So, if the command seems to hang, this is probably what is happening.

If you know that you'll only need your interactive shell for a relatively short time (less than 24h), you might want to use the `--time` flag to specify a shorter time, which will increase the chance that it will be scheduled immediately.

For example, launch a job with a time limit of 90 minutes,

`srun --account=<myPIRG> --pty --time=90 bash`

After 90 minutes, if you don't exit sooner, the job will be killed and you will be disconnected from the compute node.

## Running Interactive GPU jobs

Interactive jobs are not limited to CPU only jobs, you can also use GPUs when submitting an interactive job.

In order to do this, you’ll need to request a GPU. An example of this is seen below:

`$ srun --account=racs --partition=interactivegpu --time=20 --nodes=1 --ntasks=1 --cpus-per-task=1 --mem=500m --gpus=1 --constraint=gpu-10gb --pty bash`

`srun` → Submits and runs a job interactively in SLURM.

`-account=racs` → Specifies the PIRG that the job will run under (This is the pirg you are part of, in my case it is the `racs` pirg)

`--partition=interactivegpu` → Requests the `interactivegpu` partition, meaning it's likely optimized for interactive GPU use.

`--time=20` → Sets a time limit of 20 minutes for the job. The default is 1 hour and a max of 12 hours.

`--nodes=1` → Requests 1 compute node.

`--ntasks=1` → Specifies 1 task for the job (useful for MPI workloads, but here it just means one job instance).

`--cpus-per-task=1` → Allocates 1 CPU core per task.

`--mem=500m` → Requests 500 MB of RAM.

`--gpus=1` → Requests 1 GPU for the job.

`--constraint=gpu-10gb` → Ensures the allocated GPU has at least 10GB of memory. Nodes in the interactivegpu partiton only have GPUs with 10GB memory so in this case we don’t have to specify. However,

other gpu nodes on Talapas have 10, 40, and 80 GB of GPU memory and are requested with gpu-10gb, gpu-40gb, and gpu-80gb

`--pty` → Runs the command in a pseudo-terminal (interactive session).

`bash` → Starts a Bash shell in the allocated environment.
