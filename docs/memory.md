---
layout: default
title: Memory
nav_order: 9
---

# Memory

## Hardware Memory Quantities

Most of the current compute nodes have 512GB RAM (for 128 CPU cores).  The compute nodes that have GPUs installed have either 256GB or 512GB RAM (for 48 CPU cores).

A small number of compute nodes have 1TB, 2TB, or 4TB RAM (in these cases for 56 cores).  These are a relatively precious resource, intended to support computation that's difficult or impossible to perform on the standard compute nodes.

Almost certainly different quantities will be added as new hardware is acquired over time.

To see the actual available memory for hosts in each partition, you can use a command like this:

`sinfo -e -O partition,cpus,memory,nodes`

Currently the compute nodes have no swap space configured.  In almost all scenarios, swapping on compute nodes is unhelpful, or even counterproductive.

## Specifying Job Memory Requirements

The SLURM scheduler manages node memory, and each job run by SLURM has a specific amount of memory allocated to it.  If the amount is not explicitly specified, a default is used.

For every SLURM job you should specify the amount of memory the job needs, with the `--mem` or `--mem-per-cpu` flags.  If you don't do so, default values are used, but these are often less than ideal.

The `--mem` flag specifies the amount of RAM requested for each node in the job.  Unless you're an advanced user, this flag is probably more intuitive than the `--mem-per-cpu` flag.  See the documentation on the [sbatch](https://slurm.schedmd.com/sbatch.html "https://slurm.schedmd.com/sbatch.html") and [srun](https://slurm.schedmd.com/srun.html "https://slurm.schedmd.com/srun.html") man pages.

For memory, the default is an allocation proportional amount of available RAM from the node.  So, for example, if you request one CPU core on a node that has 28 cores and 104GB of RAM available for job use, the default will be about 3.7GB of memory.  A corollary is that if you request all of the cores for a node, you'll get all of the available RAM by default.

If your job needs more than the default, you must explicitly specify a larger value.  Alternatively, if your job needs less, you might want to specify that, which will increase the odds that it will be scheduled sooner.

As a general rule, the fewer resources your job requires, the sooner it will run.  This is because smaller jobs are easier for SLURM to schedule sooner.  (Requesting fewer resources also benefits other users by allowing SLURM to schedule cluster resources more efficiently.)  That said, if you specify less space than your job needs, it will be killed before it can complete, since these specifications are enforced.  So, you want to err somewhat on the high side.  For any given application, you might have to experiment some to get this right.

Note that a small amount of RAM on each node is reserved for system functions, in order to keep the OS and I/O operations running at full speed.

## What Happens When Memory Limits are Exceeded?

SLURM uses several mechanisms to enforce the memory limit specified for a job.  Currently, the main mechanism is a periodic check of memory usage.  About once per minute, the node SLURM daemon will check to see how much RAM ([RSS](https://en.wikipedia.org/wiki/Resident_set_size "https://en.wikipedia.org/wiki/Resident_set_size")) is in use.  If that amount is over the limit, the job will be sent a SIGTERM (followed by a SIGKILL if necessary), and the job will be put into the CANCELLED state (which can be viewed using the [sacct](https://slurm.schedmd.com/sacct.html "https://slurm.schedmd.com/sacct.html") command).  From the user point of view, in this case it will typically appear that the processes in question were killed by a signal.  Depending on how the programs being run handle signals, however, there might be other, less-than-obvious error messages as a result.  If your job is dying unexpectedly, consider the possibility that it is exceeding the amount of memory requested for it.

In addition to the above, the job's ulimit for memory is set to the requested value.  It's possible that this limit will be hit first, in which case one might expect an "out of memory" sort of error from the program (assuming that it checks for this condition).  Again, it's possible that there might be other, less-than-obvious error messages.

Recently, SLURM has started controlling this resource via the [cgroup](https://en.wikipedia.org/wiki/Cgroups "https://en.wikipedia.org/wiki/Cgroups") mechanism.  In this case, exceeding the memory limit will cause the Linux OOM-killer to be invoked, which will kill the process as if by SIGKILL.  You might also see a diagnostic message in the SLURM error log like this:

`slurmstepd: error: Detected 1 oom-kill event(s) in step 988715.batch cgroup.`

## Estimating Job Memory Requirements

In order to help estimate your job's requirements, you can use `sacct` to see what prior jobs used

`sacct -j JOBID --format=JobID,JobName,ReqMem,MaxRSS,Elapsed`

where JOBID is the numeric ID of a job that previously complete.  This will produce output like this:

```bash
sacct -j 301111 --format=JobID,JobName,ReqMem,MaxRSS,Elapsed
       JobID    JobName     ReqMem     MaxRSS    Elapsed
------------ ---------- ---------- ---------- ----------
301111        myjobname     3800Mc              16:00:28
301111.batch      batch     3800Mc    197180K   16:00:30
301111.exte+     extern     3800Mc      2172K   16:00:29
```

This job used about 193MB (197180K) of total RAM at its peak.  The job request specified about 3.7GB (3800MB) RAM per core.

For jobs that run on multiple nodes, the reported value is the maximum in use on any node.

When estimating, keep in mind that the amount of memory your job uses might be dependent on your input data sets (i.e., larger data will sometimes mean more memory is needed).  Additionally, if your job has multiple processes, the maximum amount of memory required might not even be deterministic–it might vary depending the specific timing of the how the multiple processes use and release memory. 

{: .highlight }
**As general advice, if you're running out of memory or seeing other unexpected results, try raising the memory limits to see if this seems to solve the issue.**

## Memory and MemoryLong Partitions

As mentioned above, some of the SLURM partitions (queues) contain nodes with more memory.  Specifically, the partitions with "memory" in their name currently provide much larger amounts of RAM than the standard nodes.  If it appears that your job will not run correctly or efficiently on standard nodes, try running on a "memory" node instead.

There are only a relatively small number of memory nodes, so in general you can expect to wait longer before your job is scheduled.

## Partition default memory settings

View default memory settings for each partition, run:

`/packages/racs/bin/slurm-show-def-mem`

To override the defaults, use slurm’s `--mem` flag to set total memory per node or the `--mem-per-cpu` flag to set the memory per CPU requested. 
