---
layout: default
title: How-to submit a batch job
parent: SLURM
nav_order: 1
---

# How-To Submit a batch job

You may be wondering why you can't simply run your applications in the same way that you do on your laptop or desktop. First, as a shared resource we need a method of coordinating the work of many researchers simultaneously so that users aren't stepping on each others' toes.

Second, when you first log into Talapas you will be connected to one of our "login nodes". These nodes are essentially a lobby in which users can do file management, write scripts, and submit jobs.

{: .note }
login nodes are not an appropriate place to run applications or conduct simulations. A good rule of thumb is: If it takes more than one second to complete, it's not appropriate for a login node.

Tasks should be conducted on a "compute node." These are purpose-built for running intensive computations and can only be accessed via the Slurm job scheduler. Slurm will ensure that the compute nodes are allocated in a fair and equitable manner that prevents resource conflicts. See the [Partition List]({% link docs/about_talapas/partition_list.md %}) for information on the different types of nodes on Talapas and the resources available on them. 

## Here's an entire job script example

```bash
#!/bin/bash

#SBATCH --account=<pirg>          # your slurm account is the name of your pirg
#SBATCH --partition=compute       # specify the partition, see Partition List
#SBATCH --job-name=helloworld     # name of your job
#SBATCH --output=helloworld.out   # name of batch script's standard output
#SBATCH --error=helloworld.err    # name of batch script's standard error
#SBATCH --time=0-00:01:00         # set a limit on the total run time of the job
#SBATCH --nodes=1                 # request 1 node, this is the default
#SBATCH --ntasks=1                # request 1 task run, this is the default
#SBATCH --cpus-per-task=1         # request 1 cpu per task, this is the default
#SBATCH --mem-per-cpu=4096M       # request 4GB RAM for each cpu requested

module load python3/3.11.4

script.py
```

## The indivdual components broken down

### The Shell

```bash
#!/bin/bash
```

### Resource requests

See Slurm [sbatch](https://slurm.schedmd.com/sbatch.html) documentation for more information. There's a lot more options available.

```bash
#SBATCH --account=<pirg>          # your slurm account is the name of your pirg
#SBATCH --partition=compute       # specify the partition, see Partition List
#SBATCH --job-name=helloworld     # name of your job
#SBATCH --output=helloworld.out   # name of batch script's standard output
#SBATCH --error=helloworld.err    # name of batch script's standard error
#SBATCH --time=0-00:01:00         # set a limit on the total run time of the job
#SBATCH --nodes=1                 # request 1 node, this is the default
#SBATCH --ntasks=1                # request 1 task run, this is the default
#SBATCH --cpus-per-task=1         # request 1 cpu per task, this is the default
#SBATCH --mem-per-cpu=4096M       # request 4GB RAM for each cpu requested
```

### Software dependencies

Load all software your job requires, for example python:

```bash
module load python3/3.11.4
```

### Call the program or script

Specify the location or path to the executable or script, in this example script.py is in the same directory as this job script

```bash
script.py
```

Above we see the contents of our job script called `hello.sbatch`(script name and suffix is arbitrary–use whatever name you like).

Next, we see a collection of specially formatted comments, each beginning with `#SBATCH` followed by option definitions.  These are used by the `sbatch` command to request resources and set options. This allows us to describe our job to the scheduler and ensure that we reserve the appropriate resources (cores, memory, time) for an appropriate amount of time.

## Submit your job

```bash
$ sbatch hellot.sbatch
Submitted batch job 20190
```

The job has been submitted and is assigned the job number 20190 which will serve as its primary identifier.

## Check job status

Use the `squeue` command.

```bash
$ squeue
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
             20190 compute  hellowworld   duckID R       1:09      1 n0111
             ...
```

Here we see that our job, number 20190, is running 'R' state. Jobs in the system may be in R, PD, CG state (running, pending, completing).

To view your jobs, run the Slurm command `squeue -u <duckid>`.

If you need to cancel your job for any reason, run the Slurm command `scancel <job_id>` for example `scancel 20190
