---
layout: default
title: How-To Use the preempt Partition
parent: Slurm
nav_order: 10
---

# How-To Use the preempt Partition

Talapas has a special Slurm partition (queue) named `preempt` that provides low-priority access to almost every compute node in the cluster–even compute nodes that you normally wouldn't have permission to use (_e.g._, because they're condo nodes owned by a lab).  If you're able to use this partition for your job, it might be scheduled for execution far sooner than it would be on one of the ordinary queues.

**There is a catch, though.**  A job submitted to `preempt` will only be scheduled on an otherwise-idle resource, and even after the job is started, if the resource is needed by any other (non-`preempt`) job, the `preempt` job will be _immediately killed_.

The good news is that the cluster virtually always has some free resources, so your `preempt` job will often be scheduled immediately, or quite soon.

Be aware that the current Talapas default is not to requeue preempted jobs.  If you want your job to requeue, use the `--requeue` flag described below.  In the worst case with requeueing enabled, this might happen several times, but eventually your job will be run to completion.  You might find this requeueing confusing.

An additional limitation is that jobs in `preempt` are currently **limited to seven days**.

## Submission

Submitting a job to the `preempt` partition is largely the same as submitting it to any other queue.  As above, if you want your job to be automatically requeued, you'll need to include this option (i.e. `#SBATCH --requeue`) either in your batch script or on the `sbatch` command line.  If you don't do this, your job will not be re-run if it's preempted.

In order to make your job "requeue-friendly", you might need to have your script delete leftover files from the initial run, and perhaps take other actions that you might normally perform to reset for the repeated invocation.

(There is an environment variable `SLURM_RESTART_COUNT` that will be set for requeued runs, though you'll almost never need to notice this in your job.)

A requeued job starts over from the beginning of your script, and its output file may be overwritten (the default depends on cluster configuration). Add `--open-mode=append` if you want output from every run kept in the same file. If your program can write checkpoints, have it resume from the latest one when it starts.

Here is an example job script for the `preempt` partition:

```bash
#!/bin/bash

#SBATCH --account=<pirg>          ### your slurm account is the name of your pirg
#SBATCH --partition=preempt       ### low-priority access to nearly all nodes
#SBATCH --job-name=preempt-test   ### name of your job
#SBATCH --output=preempt-test.out ### name of batch script's standard output
#SBATCH --error=preempt-test.err  ### name of batch script's standard error
#SBATCH --open-mode=append        ### append to output files when the job is requeued
#SBATCH --time=0-04:00:00         ### set a limit on the total run time of the job
#SBATCH --nodes=1                 ### request 1 node
#SBATCH --ntasks=1                ### request 1 task
#SBATCH --cpus-per-task=1         ### request 1 cpu per task
#SBATCH --mem-per-cpu=4096M       ### request 4GB RAM for each cpu requested
#SBATCH --requeue                 ### put the job back in the queue if it is preempted

echo "Restart count: ${SLURM_RESTART_COUNT:-0}"

./my_program
```

Jobs on `preempt` get the same default memory per CPU as the other partitions (see the [Memory]({% link docs/about_talapas/memory.md %}) page), and you should always set `--time` explicitly.  However, because all of the compute nodes are available for scheduling, you can request any combination of resources that can be satisfied by any of our compute nodes.  So, for example, you could request 800GB of memory–this would result in the job being run on one of our "fat" nodes, since only those nodes have that much memory.  Similarly, you could request one or more GPUs, which would cause the job to be scheduled only on a node that had GPUs.  As always, the fewer resources you request, the sooner your job is likely to run.

## Strategy

Because preempt jobs will be killed as needed, it's worth thinking about how to reduce the probability that this will happen to your job.  Using a smaller CPU core count might help.  Intuitively, this makes it less likely that the CPUs your job is using will get "unlucky".  This somewhat depends on how core count affects your job's run time.  If the choice is between a job that uses two CPUs for eight hours or eight CPUs for two hours, the chances of being preempted might be quite similar.  Usually jobs aren't perfectly parallelized, though, so reducing CPU count could be a win.

**Multi-node MPI jobs** are a distinct case.  There is often a choice between using whole nodes versus allowing Slurm to place them wherever is expedient.  Although the latter option is attractive for other reasons, empirically, it seems to increase the chances of preemption.  As a conjecture, this might be because some tasks are placed on the popular club partitions (e.g., 'compute').  Because small jobs are submitted to these partitions frequently, there is a higher chance that one will collide with the preempt job.  And the loss of even a single task (CPU) usually results in a crash of the entire MPI job.

See the [How-To Submit an MPI Job]({% link docs/slurm/how-to_submit_an_mpi_job.md %}) page for additional information.

See also the [How-To Submit a GPU Job]({% link docs/slurm/how-to_submit_a_gpu_job.md %}) page if you want to run on GPUs in `preempt`.
