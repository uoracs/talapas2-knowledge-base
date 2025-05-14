---
layout: default
title: How-To Submit a Job
parent: How-To Articles
nav_order: 2
---

# How-To Submit a Job

You may be wondering why you can't simply run your applications in the same way that you do on your laptop or desktop. First, as a shared resource we need a method of coordinating the work of many researchers simultaneously so that users aren't stepping on each others' toes.

Second, when you first log into Talapas you will be connected to one of our "login nodes". These nodes are essentially a lobby in which users can do file management, write scripts, and submit jobs.

{: .note }
login nodes are not an appropriate place to run applications or conduct simulations. A good rule of thumb is: If it takes more than one second to complete, it's not appropriate for a login node.

Instead, these tasks should be conducted on a "compute node." These are purpose-built for running intensive computations and can only be accessed via the [Slurm](https://slurm.schedmd.com/) job scheduler. Slurm will ensure that the compute nodes are allocated in a fair and equitable manner that prevents resource conflicts. The primary method by which you will run simulations on Talapas will be to "submit a job."

## Components of a job Slurm job script

### The Shell

```bash
#!/bin/bash
```

### Slurm resource requests

See Slurm [sbatch](https://slurm.schedmd.com/sbatch.html) documentation for more information.

```bash
#SBATCH --account=<myPIRG>
#SBATCH --partition=compute
#SBATCH --job-name=HiWorld
#SBATCH --output=Hi.out
#SBATCH --error=Hi.err
#SBATCH --time=0-00:01:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=500M
```

### Program dependencies

Load all software your job requires, for example python:

```bash
module load python3/3.11.4
```

### Call the program or job steps

```bash
./a.out
```

## Slurm job script

Example of a job script:

```bash
#!/bin/bash

#SBATCH --account=<myPIRG>
#SBATCH --partition=compute
#SBATCH --job-name=hiworld
#SBATCH --output=hi.out
#SBATCH --error=hi.err
#SBATCH --time=0-00:01:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=500M

module load python3/3.11.4

./a.out
```

Above we see the contents of our SLURM script (aka job script) called `hello.sbatch`(script name and suffix is arbitrary–use whatever name you like).  Notice that the script begins with `#!/bin/bash`. This line tells Linux which shell interpreter to use when executing the script. We used `bash` (the Bourne Again Shell) and it's by far the most common choice.

Next, we see a collection of specially formatted comments, each beginning with `#SBATCH` followed by option definitions.  These are used by the `sbatch` command to set job options. This allows us to describe our job to the scheduler and ensure that we reserve the appropriate resources (cores, memory, time) for an appropriate amount of time.

## Submit your job

to the scheduler using the `sbatch` command.

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
             20190 computelo  HiWorld   duckID CG       1:09      1 n074
             ...
```

Here we see that our job, number 20190, is in the CG (completing state). Jobs in the system may be R (running) or PD (pending ).

Jobs are pending when there are insufficient resources available to accommodate the request as specified in the job script.

To view only your jobs, run `squeue -u <myDuckID>`.

If necessary, cancel your job using the `scancel` command followed by the job number of the job you wish to cancel, i.e. to cancel this submitted job with JOBID = 20190, you would run: `scancel 20190`.
