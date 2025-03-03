---
layout: default
title: Quick Start Guide
nav_order: 2
---

# Quick Start Guide

## Getting a Talapas Account

If you don't already have an account, see the [Request Access](https://racs.uoregon.edu/request-access) page to get one.

## Logging on to Talapas

See our guide: [How-to Login to Talapas]({% link docs/how-to_articles/how-to_login_to_talapas.md %})

## Transferring Files to and from Talapas

If you're accessing Talapas from Linux or Mac OS X, you can use `scp` to transfer files.  For example, type

`scp chr1.fasta myusername@login.talapas.uoregon.edu:.`

to copy the named file to your Talapas home directory.

There are also GUI tools available for file transfer via SCP or SFTP.  [Filezilla](https://filezilla-project.org/) is available for all common platforms.

Globus is the fastest method of file transfering and the one that RACS reccomends the most. For more information see the [Globus]({% link docs/data_movement/globus/globus.md %}) pages.

See the [Data Movement]{% link docs/data_movement/data_movement.md%} documentation page for more details. 

## Storing your Data

As a Talapas user, you have these directories available for storing and manipulating your files.

- Your Linux home directory.  This is the directory you start in when you log in.  It's shared across all Talapas hosts.  This directory is for small configuration files, etc.  The quota is limited to 250GB and cannot be expanded.
- Your project directory, `/projects/GROUP/`, where _GROUP_ is the name of your PIRG (and also your Linux primary group).  This is the directory you should use for large data files, etc.  This directory shares a large quota with your PIRG.
- Your PIRG's shared directory, `/projects/GROUP/shared`.  This directory is for data that you want to share with other members of your PIRG.  It also shares the PIRG quota, which can be expanded as needed.
- The host temporary directory, `/tmp`.  Unlike the other directories, this directory is on a local host disk drive and is not shared across hosts.  It's for temporary data during a job.  Using this directory for intermediary data may speed up your job.  Please delete files you create here at the end of your job.

{: .warning }
**You are responsible for backing up all of your data on Talapas.  This data is not backed up by RACS.**
Some snapshotting is performed for all directories except for the host temporary directory, and in some cases lost files can be recovered from a snapshot.  This cannot be relied on as a backup, however.

See the [Storage]({% link docs/storage.md %}) documentation page for more details.

## Software

Read about how to find software on our [Software]({% link docs/software/software.md %}) page.  Read on for the absolute basics.

Talapas uses the [Lmod](https://lmod.readthedocs.io/en/latest/) environment module software to provide access to the various installed software packages.  Type:

`module spider blast`

to see the available modules that are named like "blast", for example.

To load a module so that you can use its commands, type:

`module load NAME`

where _NAME_ is the specific name of the module you'd like to load.  (You can specify the version as well, or omit it to get the default version.)

This may also load other modules needed by the module in question.  If you'd like to see all modules currently loaded, type:

`module list`

Note that the module is loaded just for the current shell instance.  You'll need to do this again for each new shell.

If you need to unload a module, type:

`module unload NAME`

(Lmod separates modules into groups in order to avoid having incompatible modules loaded simultaneously.  To search for just modules that can be loaded without switching groups, use `module avail` instead of `module spider`.)

If you would like to unload **all** currently loaded modules, you can use the command below:

`module purge`

See [How-To Use LMOD]({% link docs/how-to_articles/how-to_use_lmod.md %}) for more details.

## SLURM Accounts

In order to ensure correct service charges, all SLURM jobs on Talapas require that an account be specified.  You can do this explicitly using the `--account` (or `-A`) option to `sbatch` or srun.  This is shown in the first example below, but omitted from the rest for clarity.  Alternatively, you can set the environment variables `SLURM_ACCOUNT` and `SBATCH_ACCOUNT` in your `~/.bash_profile` if you like.

If your SLURM job invokes subsidiary calls to `sbatch`, you might also need to include lines like this in your batch script to make sure that the subsidiary `sbatch` calls also see the account information:

```bash
export SLURM_ACCOUNT=$SLURM_JOB_ACCOUNT
export SBATCH_ACCOUNT=$SLURM_JOB_ACCOUNT
```

Note that if you a member of multiple PIRGs, it is your responsibility to specify the correct account for each job.

If you're not sure what your PIRG/account name is, you can use the groups command.  It will show a list of groups that you're in.  A few are system groups that you cannot charge to (_e.g._, `talapas`, `gaussian`).  But within that list you should recognize the PIRGs that you are a member of.

## Running a Batch Job

Talapas uses the [SLURM](https://slurm.schedmd.com/) job scheduler and resource manager to provide a way to submit large computational tasks to the cluster in a batch fashion.

As a basic example, here is a simple batch script to run the `hostname` command on one compute node.  To run it, first create a file `hostname.batch` containing these lines:

```bash
#!/bin/bash
#SBATCH --account=<myaccount>   ### change this to your actual account for charging
#SBATCH --partition=compute     ### queue to submit to
#SBATCH --job-name=myhostjob    ### job name
#SBATCH --output=hostname.out   ### file in which to store job stdout
#SBATCH --error=hostname.err    ### file in which to store job stderr
#SBATCH --time=5                ### wall-clock time limit, in minutes
#SBATCH --mem=100M              ### memory limit per node, in MB
#SBATCH --nodes=1               ### number of nodes to use
#SBATCH --ntasks-per-node=1     ### number of tasks to launch per node
#SBATCH --cpus-per-task=1       ### number of cores for each task

hostname
```

Then, to actually submit the job for execution, type:

`sbatch hostname.batch`

When a job is submitted, SLURM considers all of the resources requested (e.g., CPU cores, memory, time, GPUs) together with the set of currently running and queued jobs.  Once compute nodes are available to run your job, it will be run.

Note that your job will _not_ run until the resources you have requested are available.  This means that you may be able to get your job to run sooner by requesting fewer resources.  For example, if your job will run in 1000MB, it's better not to request 10000MB, as it may take significantly longer for those resources to become available.

Batch jobs are run in a manner that's not dependent on your current terminal, so once a job is submitted, it no longer depends on your being logged in, etc.  Job output will be available in the specified files when it has completed.  You can monitor your job's progress using the `squeue` and `sacct` commands.  For example

```bash
$ sbatch hostname.batch
Submitted batch job 12345

# checking with squeue, we see that the job has started running (state is 'R')
$ squeue -j 12345

   JOBID PARTITION     NAME        USER ST       TIME  NODES NODELIST(REASON)
    12345  compute     myhostjob   joec  R       5:08      1 n003

# later, we see that the job has successfully completed
$ sacct -j 12345

       JobID    JobName  Partition    Account  AllocCPUS      State ExitCode
------------ ---------- ---------- ---------- ---------- ---------- --------
12345       myhostjob+    compute    joegrp         1     COMPLETED      0:0
12345.batch      batch               joegrp         1     COMPLETED      0:0
12345.exte+     extern               joegrp         1     COMPLETED      0:0
```

If needed, you can also kill a job using its job id.  This will terminate it if it has already started running, or remove it from the queue if it hasn't started yet.

`scancel 12345`

SLURM uses a number of queues, which it calls _partitions_, to run jobs with different properties.  Normal jobs will use the compute partition, but there are other partitions for jobs that need to run longer than a day, need more memory, or need to use GPUs, for example.  You can use the `sinfo` command to see detailed information about the partitions and their states.

See the [Partition List]({% link docs/partition_list.md %}) page for information on the available partitions.

## Tracking your job

To monitor the progress of your job—from submission to execution and completion—refer to our [How-To Track Submitted Job Status]({% link docs/how-to_articles/how-to_track_submitted_jobs.md %}) guide. This documentation provides step-by-step instructions on the most effective method to stay updated on your job's status.

## Running an Interactive Job

For long-running computational tasks, batch jobs are the way to go.  But sometimes you will want to get an interactive shell on a compute node.  This is useful for quickly testing your scripts, or for running interactive programs like MATLAB or SAS that are too computationally intensive to run on a login node.

You can start a shell like this

`srun --account=hpcrcf --pty --partition=compute --mem=1024M --time=240 bash`

Most of the flags work just as in batch scripts, above.  This command requests a single core (the default) on a node in the compute partition, with 1024MB of memory, for four hours.  (After four hours, the shell and all commands running under it will be killed.)

This will often start your shell immediately, but if all nodes are in use, you might have to wait a while.  The shell will start once resources become available.

In most regards, this works like a typical remote shell.  If your local workstation crashes, for example, the shell will be logged out.  For this reason, batch jobs are better when feasible.

The above command is good for running single programs.  If you'll be doing something that will invoke multiple parallel processes or threads, like a parallel make or multi-threaded program, you might want to add a `--cpus-per-task=N` flag to allocate more cores. 

{: .note }
Note that on Talapas, using `--ntasks` (or `-n`) instead of `--cpus-per-task` (or `-c`) is virtually always the wrong thing to do, and will make your session run more slowly.

## Running Graphical Interactive Jobs

If your interactive job will involve a program like Rstudio, which uses X11 to provide graphical output, there are several options.  You can use the `srun --x11` flag like so to forward your X11 connection back to your workstation X server.

`srun --account=hpcrcf --x11 --pty --partition=compute --mem=4G --time=4:00 bash`

For some cases, the alternative script `xrun` works better.

`xrun --account=hpcrcf --partition=compute --mem=1024 --time=4 bash`

Note that this script supports only a subset of the `srun` flags and has some quirks.  The `--mem` value must be a whole number and is in megabytes.  The `--time` value is in HH:MM format, but if only a whole number is specified, it is take as hours (rather than minutes).

In order for this to work correctly, you will need to be running an X server on your local workstation, and you'll have to forward X traffic when you connect to a login node.  This is typically done by using `ssh -Y` or its equivalent.

The final option, which is far simpler if it works for your case, is to simply start a desktop session using Open OnDemand.  This does not require an X11 server on your workstation, but rather runs the server on the compute node, forwarding traffic via a web browser-based VNC client.  See the [[Open OnDemand]] page for more details.

## Requesting Space and Time

For every SLURM job you should specify the amount of memory the job needs (with `--mem` and related flags) and the amount of time it needs (with `--time`).  If you don't do so, default values are used, but these are often less than ideal.

As a general rule, the fewer resources your job requires, the sooner it will run.  This is because smaller/shorter jobs are easier for SLURM to schedule sooner.  (Requesting fewer resources also benefits other users by allowing SLURM to schedule cluster resources more efficiently.)  That said, if you specify less space or time than your job needs, it will be killed before it can complete, since these specifications are enforced.  So, you want to err somewhat on the high side.  For any given application, you might have to experiment some to get this right.

For memory, the default is to be allocated a proportional amount of available RAM from the node.  So, for example, if you request one CPU core on a node that has 28 cores and 104GB of RAM, the default will be about 3.7GB of memory.  (A corollary is that if you request all of the cores for a node, you'll get all of the available RAM by default.)  Some nodes have more cores and/or RAM, so this may vary, but 3.7GB is currently the smallest default for all Talapas nodes.  See [Machine Specifications](https://hpcrcf.atlassian.net/wiki/spaces/TCP/pages/6763193/Machine+Specifications) for more detailed information about the available nodes.

If your job needs more than the default, you must explicitly specify a larger value.  Alternatively, if your job needs less, you might want to specify less, which will increase the odds that it will be scheduled sooner.

For time, the default varies by partition, but is generally the maximum available for the partition.  For the compute partition, the default is currently 24 hours.  For the computelong partition, it's currently two weeks.  If your job will take significantly less time, you can specify a shorter duration, to increase the odds that it will be scheduled sooner.

In order to help estimate your job's requirements, you can use sacct to see what prior jobs required

`sacct -j JOBID --format=JobID,JobName,ReqMem,MaxRSS,Elapsed`

where JOBID is the numeric ID of a job that previously complete.  This will produce output like this

```bash
sacct -j 301111 --format=JobID,JobName,ReqMem,MaxRSS,Elapsed
       JobID    JobName     ReqMem     MaxRSS    Elapsed
------------ ---------- ---------- ---------- ----------
301111        myjobname     3800Mc              16:00:28
301111.batch      batch     3800Mc    197180K   16:00:30
301111.exte+     extern     3800Mc      2172K   16:00:29
```

This job used about 193MB (197180K) of RAM at its peak and ran for a bit over 16 hours.

There's also a helper script `seff` that provides similar information and is a bit easier to type.  Just say `seff JOBID`.

See the [Memory]({% link docs/memory.md %}) documetation page for more details.

## Special Handling for Quarterly Maintenance Events

Approximately once per quarter, Talapas is taken down for maintenance, to update software and hardware, make repairs, etc.  To minimize the disruption, SLURM reservations are added to "block out" those times.  If you take no special steps, a job request that you make that runs into a maintenance window will be held and run _after_ the window.

This is often what you'd want.  But, sometimes you might want a job to start right away, even if the entire optimal running time is not available.  You can specify this using the `--min-time` flag to specify a minimum acceptable time limit for the job.

```bash
#SBATCH --time=0-8:00:00
#SBATCH --time-min=0-1:00:00
```

Using the above flag, you'll normally get a time limit of eight hours.  But, if there are reservations that would delay the start of your job, SLURM will consider any  time limit down to one hour to be acceptable and start the job immediately.  (SLURM will prefer the largest available time limit.)

## Being a Good Cluster Citizen

Always keep in mind that the cluster is a shared resource and that your behavior can negatively affect other users.  In furtherance of overall user experience, significant computation on the login nodes is forbidden, as mentioned above.

Similarly, "wasting" compute time, etc., with jobs that are idling or simply meant to "hold" a node is likewise forbidden.  When you're done with an interactive job, please log out.  If you have an upcoming deadline, please talk to us about your needs, rather than grabbing and holding compute resources.

In short, don't be _that user_.  Your fellow users will thank you!

## Getting Help

If you run into trouble, see the more detailed documentation on this site, or feel free to [submit a ticket](https://hpcrcf.atlassian.net/servicedesk/customer/portal/1) describing your problem.  It will be very helpful if you can provide the job ID in question, together with the script you're trying to run and any error messages, etc.
