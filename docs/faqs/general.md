---
layout: default
title: General FAQs
nav_order: 1
parent: FAQs
---

# General FAQs

## "My jobs on Talapas are crashing immediately, what's wrong??"

By default, users are assigned one core at a time, and a chunk of memory (~4GB RAM) associated with that core.

For many applications, this may not be enough memory.  To get around this, one can reserve more cores:

`srun --account=<myPIRG> --cpus-per-task=28 --pty` `bash`

This will reserve all 28 cores on a basic node, which should suffice for most applications.

Alternatively, if you just want to reserve more memory, do:

`srun --account=<myPIRG> --mem=50G --pty` `bash`

This will reserve 1 core but 50GB RAM on a node.

It may be useful to try reserving a full node and determine how much RAM is needed for your application, then future jobs can be adjusted accordingly.

If your jobs are crashing for a different reason, check that you are not exceeding a disk quota (e.g. your home directory quota).  If it is not the quota, please submit a ticket and let us know the jobid of the job that crashed.

## "How do I view my disk usage and quota?"

You can now view your disk usage and your current quota using the `/usr/local/bin/quota` command.

The first lines give your usage and quota, and additional lines give group usages and quotas for all the groups that you are a member of.

## "Oops!  I just accidentally deleted some of my files and directories.  Can you please recover them?"

You just might be in luck. Talapas does NOT have backups, but it does take regular filesystem snapshots.  These are located in the directory `/gpfs/.snapshots/`

Snapshots are taken at the following times:

end of each day (before midnight, Sunday through Friday):  _daily-{Sun-Fri}_

end of each week (before midnight on Saturday):  _weekly-{week # of month}_

For example, to copy your deleted file from your project directory from last Friday:

`cp /gpfs/.snapshots/daily-Fri/projects/myPIRG/myDataDir/path/to/myDeletedFile .`

Your data may be accessible from within the snapshot, but once the old snapshot has been replaced by a new snapshot, data unique to the older snapshot will be gone.

{: .warning }
Users are responsible for backing up their own data!_  Please see the FAQ below on how to transfer your files off of Talapas.

## "What is the best way to transfer my files to/from Talapas?"

**From a Mac or Linux machine:**

Perhaps the easiest way for you to do this is by using rsync, e.g.:

`rsync -auv myDuckID@dtn01.uoregon.edu:/projects/myPIRG/myDuckID/myDataDirectory myDestinationDirectory`

Alternatively you can use scp:

`scp -rp myDuckID@dtn01.uoregon.edu:/projects/myPIRG/myDuckID/myDataDirectory myDestinationDirectory`

Each of the examples above will create for you a directory named `myDestinationDirectory` on your local Mac/Linux machine.

If your transfer gets interrupted, then try `rsync` with the `u` option (for update).

**From a Windows machine:**

You will need a FTP/SCP client like WinSCP or Cyberduck (Cyberduck is also available for Mac).

Globus and GridFTP is also available on Talapas (see HOWTOs for more info).

After your transfer has completed, you can reorganize as you please. If you need further assistance on your file transfer, let us know.

## "How can I extend my jobs on Talapas?"

It is currently not possible for a user to extend their jobs on Talapas.

## "Why is my job pending with 'ReqNodeNotAvail' message when I type squeue?"

See [FAQ: Why is my SLURM job not running?]({% link docs/faqs/why_is_my_job_not_running.md %})

## "I'm seeing an error mentioning a directory `/run/user`, and it's causing trouble.  How do I fix it?"

The SLURM commands pass all environment variables into your job by default.  One of the variables, `XDG_RUNTIME_DIR`, references a special directory in `/run/user` that will not exist on your compute node.  Programs are supposed to ignore this, but some do not.  You can work around this by including the line below as the first line of your script following all `#SBATCH` declarations.

```bash
#!/bin/bash
#SBATCH --account=<myPIRG>

...

unset XDG_RUNTIME_DIR
```

## "I have exceeded my disk quota, can you increase it?"

Most quota issues involve the home directory.  All users gets a hard 10GB quota that is fixed and _will not be increased_. We recommend that users use their project directory, `/projects/<myPIRG>/<myUsername>/`, to write and store their data.  By default, PIRGs have minimum of 2 TB to work with in their project directories, and users have a shortcut in their home directory that points to their projects directory so that it can be accessed from the home directory by just doing `cd <myPIRG>`. 

If you do not have this shortcut and would like to have it, perform the following commands:

```bash
cd ~
ln -s /projects/<myPIRG>/<myUsername> <myPIRG>
cd <myPIRG>
```

You can now work from your projects folder.

Your project usage and your PIRGs usage and quota are displayed on login.  Your project quota is a soft quota - if your group's project quota has been exceeded, your group will have a 30 day grace period to bring it back under the quota.  If that does not happen, it becomes a hard quota and no new files can be created or stored. 

If that becomes the case and your group needs your project quota increased, let us know at _racs@uoregon.edu_.

## "Why can't I submit a job, I keep getting 'srun: error: AssocGrpSubmitJobsLimit' or 'Job violates accounting/QOS policy' message?"

You may be getting this message if you have not specified your PIRG in your job submission.  This is now required.  To fix this, do the following:

For `srun`: add this: `srun -A <myPIRG> ...` or `srun --account=<myPIRG> ...`

NOTE: The 'srun' command will **NOT** pay attention to '#SBATCH' directives, so if the account is not specified using an argument, you will get this error!

For `sbatch`, include the following directive in your submission script:

`#SBATCH -A <myPIRG>` or `#SBATCH --account=<myPIRG>`

If you have added the correct account information and you still cannot submit your jobs, contact us.
