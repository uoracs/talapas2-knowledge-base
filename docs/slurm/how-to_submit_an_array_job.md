---
layout: default
title: How-To Submit an Array Job
parent: Slurm
nav_order: 2
---

# How-To Submit an Array Job

## Step-by-step guide

While Slurm is not designed for HTC (High Throughput Computing) workloads, the use of job arrays can facilitate HTC like job submissions. To launch an array of jobs:

1. Set the "array" option in your Slurm script
2. Use the resulting integer values to loop over your simulations, either by reading the integer into your executable as an input or by translating its value into filenames, directories, etc.

Let's look at a simple example:

```bash
#!/bin/bash

#SBATCH --account=<myPIRG>     ### Account used for job submission
#SBATCH --partition=compute    ### Partition
#SBATCH --job-name=ArrayJob    ### Job Name
#SBATCH --time=00:10:00        ### WallTime
#SBATCH --nodes=1              ### Number of Nodes
#SBATCH --ntasks=1             ### Number of tasks per array job
#SBATCH --array=0-19           ### Array index

echo "I am Slurm job ${SLURM_JOB_ID}, array job ${SLURM_ARRAY_JOB_ID}, and array task ${SLURM_ARRAY_TASK_ID}."
```

 Let's look at the output of this job:

```bash
[duckid@login1 array]$ sbatch array.srun
Submitted batch job 20303
[duckid@login1 array]$ cat slurm-20303_1.out
I am Slurm job 20305, array job 20303, and array task 1.
&.out
I am Slurm job 20323, array job 20303, and array task 19.
[duckid@login1 array]$
```

Note that all jobs in the array share the same `SLURM_ARRAY_JOB_ID` but have a different `SLURM_JOB_ID`, i.e. they're separate jobs as far as Slurm is concerned. Most importantly, note the value of `SLURM_ARRAY_TASK_ID` corresponds directly to the array values we specified in our Slurm script. It's this value we will use to communicate to the job which specific job within the array of jobs that it's running.

Slurm will run the constituent jobs as resources become available.  It's even possible that they might all start simultaneously.  See the Slurm docs if you need to limit parallelism.
