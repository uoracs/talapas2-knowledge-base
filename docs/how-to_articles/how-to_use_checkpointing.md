---
layout: default
title: How-To Implement Checkpointing
parent: How-To Articles
nav_order: 20
---

# How-To Implment Checkpointing

## What Is Checkpointing?

Checkpointing is the practice of periodically saving the state of a running program so that it can be resumed later from that point.
This is especially important for long-running jobs on shared computing clusters like Talapas, where wall-time limits or unexpected
failures can interrupt computation.

By checkpointing regularly, you can avoid restarting jobs from scratch in the event of failure. If your job can make use of checkpointing,
then you can make better use of the "preempt" partition, allowing your job to take advantage of the condo resources on Talapas while they are not in use,
without worrying about lost progress if/when your job is "preempted". Additionally, checkpointing enables you to have long-running jobs (longer than the partition walltime limits),
without the danger of unexpected cluster failures or having to ask RACS admins to increaase your job's time limit.

## Checkpointing Strategies

Depending on each user's specific workflows and software used, there are different applicable checkpointing strategies.

### 1. Application-Level Checkpointing

Some applications (e.g., TensorFlow, PyTorch, GROMACS, OpenFOAM) have built-in support for checkpointing.
This is usually the most efficient and robust method. Consult your application’s documentation for checkpointing options.

### 2. Manual Checkpointing in Code

Researchers writing their own code can implement checkpointing manually by:

- Periodically saving variables or program state to disk (e.g., using Python’s `pickle`, NumPy’s `save`, or writing to HDF5 files).
- Writing restart logic that loads from these saved states when the job starts.

### 3. System-Level (Transparent) Checkpointing

When application-level or manual checkpointing is not feasible, transparent checkpointing can be used to checkpoint most generic user-space processes.
The word "tansparent" in this case is in reference to that this process requires no modifications to your code or the kernel, and can be operated at the user-level.
Talapas supports transparent checkpointing through the Distributed MultiThreaded CheckPointing ([DMTCP](https://dmtcp.sourceforge.net/)) software library.

## Using DMTCP on Talapas

### What Is DMTCP?

DMTCP is a user-space checkpointing tool that can save and restore the state of distributed and multithreaded applications without modifying source code or requiring root privileges.

DMTCP supports a variety of applications, frameworks and programming languages including OpenMP, MATLAB, Python, C, C++, Fortran, shell scripting languages, and workflow management tools.

{: .note }
We currently do not support the DMTCP plugins required to support checkpointing of MPI jobs. If you are hoping to implement transparent checkpointing for an MPI job please submit a ticket to our [RACS support portal](https://hpcrcf.atlassian.net/servicedesk/customer/portal/1) and we can help to get a working solution for your workflow.

DMTCP uses a central coordinator process to accept user instructions and manage Checkpointing/Restarting operations as shown in the figure below. There is one DMTCP coordinator for each application to be checkpointed; the `dmtcp_coordinator` command runs this on one of the nodes allocated to the job. Second, application tasks are started with DMTCP integration using `dmtcp_launch` which connects to the coordinator. For each user process in the application, a checkpoint thread is spawned that executes C/R instructions from the coordinator. When prompted by either a user command to the coordinator or automatically with a given frequency, DMTCP checkpoints the state of the launched application and preserves everything on disk. The application can then be restarted from the checkpoint data on disk using the `dmtcp_restart` command.

![DMTCP Arch](../../../assets/images/dmtcp_arch.png)

{: .warning }
Transparent System-level checkpointing, while extremely useful in some use cases, does not come without its own issues.
DMTCP is not expected to be stable for GPU based jobs, and while it is meant to work with most software, it may not always work.
If you go down this route for checkpointing, make sure and do some tests to ensure that the checkpointing does not affect your workflows performance or results.

### Loading DMTCP

DMTCP is available as a module on Talapas:

```bash
module load dmtcp
```

### Interactive/Manual Checkpointing

The process for setting up DMTCP for interactive checkpointing is as follows:

1. Request an interactive terminal session on a compute node:

    ```bash
    srun --account=<MY_PIRG> --pty --partition=interactive --time=60 bash
    ```

    Load the dmtcp module:

    ```bash
    module load dmtcp
    ```

2. Open a second terminal on a Talapas login node, then SSH into the compute node allocated to you from the first step (i.e. if your job was on n0398, then on the login node run `ssh n0398`). Next start the `dmtcp_coordinator` in this second terminal session:

    ```bash
    module load dmtcp
    dmtcp_coordinator
    ```

3. On the **first** terminal session, launch your program (with any needed args at the end of the line):

    ```bash
    dmtcp_launch --join-coordinator ./your_program
    ```

4. While the job is running in your first terminal session, you can interact with the `dmtcp_coordinator` in the second terminal session. Type '?' to list available commands, 'c' to intiate a checkpoint, 's' for querying the job status, and 'q' for terminating the job.

5. After intiating a checkpoint and then killing your program in your first terminal you can then restart from the checkpoint with:

    ```bash
    dmtcp_restart --join-coordinator ckpt_your_program_*.dmtcp
    ```

### Regular Frequency Checkpointing

The quickest way to setup DMTCP for your job is to set it to checkpoint at regular intervals. With this setup you do not need to explicitly start a
`dmtcp_coordinator` process, as it will automatically start this in the background. To launch a program with checkpointing at a frequency of every `<INTERVAL_IN_SECS>` you would run:

```bash
dmtcp_launch -i <INTERVAL_IN_SECS> ./your_program
```

With any arguments to pass to `./your_program` listed at the end of that line. This will create checkpoint files (`.dmtcp` file extenstion) in your working directory each time your requested interval passes,
and upon interruption, a bash script named `dmtcp_restart_script.sh`. Running this script will automatically restart the program from the latest checkpoint.

```bash
./dmtcp_restart_script.sh
```

You can specify the location to store the checkpoint files with the `--ckptdir` option to your `dmtcp_launch` command.

To restart your program from a specific checkpoint file instead of the latest, you can run:

```bash
dmtcp_restart ckpt_your_program_***.dmtcp
```

While the shell script works great in interactive environments, it will write out some hostnames of the specific node your job ran on, meaning sometimes it can fail if a resubmitted job
gets sent to a different compute node. In this case, use the `dmtcp_restart` command explicitly giving it a specific checkpoint file.

### Checkpointing and Restarting Batch Jobs

To setup checkpointing for SLURM batch jobs, the easiest and most reliable setup is to create two sbatch scripts for your job: one to submit the initial job with checkpointing, and another to restart from the latest checkpoint.

A sample sbatch script to submit a checkpointed job would like like this:

```bash
#!/bin/bash
#SBATCH --account=<MY_PIRG>
#SBATCH --name=test_submit
#SBATCH --partition=compute
#SBATCH --time=0-00:10:00 ### 10 minutes
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

module purge
module load dmtcp

#checkpointing once every minute
export CKPT_INTERVAL=60

#location to store ckpt files
export CKPT_DIR=/scratch/<MY_PIRG>/<MY_USERNAME>/dmtcp_ckpts/

#make the ckpt dir if it does not exist
if [ -d "$CKPT_DIR" ]; then
    mkdir -p $CKPT_DIR
fi

#running w/ regular checkpoint freq 1/min
dmtcp_launch -i $CKPT_INTERVAL --ckptdir $CKPT_DIR ./your_program
```

And following a similar form the sbatch script to restart this job would look like this:

```bash
#!/bin/bash
#SBATCH --account=<MY_PIRG>
#SBATCH --name=test_restart
#SBATCH --partition=compute
#SBATCH --time=0-00:10:00 ### 10 minutes
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

module purge
module load dmtcp

#location to find the stored ckpt files
export CKPT_DIR=/scratch/<MY_PIRG>/<MY_USERNAME>/dmtcp_ckpts/

#Resume checkpoint from file
dmtcp_restart $CKPT_DIR/ckpt_your_program_*.dmtcp
```
