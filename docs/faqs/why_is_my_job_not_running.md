---
layout: default
title: "FAQ: Why is my SLURM job not running?"
nav_order: 2
parent: FAQs
---

# FAQ: Why is my SLURM job not running?

Broadly, once submitted, your job might not run immediately because the resources required to run it aren't available, either because they're in use or because they simply don't currently exist.  Unfortunately, the error messages and reason codes that SLURM provides can be a bit opaque, so in this article we'll explain some common cases.

The first thing you'll want to do is look at the reason code for the job.  This can be found in the output of the `squeue` command, for example:

```bash
$ squeue -u $USER
  JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
  1981319   compute  myjob12  joecool PD       0:00      1 (Resources)
  1981320   compute  myjob12  joecool PD       0:00      1 (Priority)
  1981321   compute  myjob12  joecool PD       0:00      1 (Priority)
```

In this output, we see examples of two reason codes.

The code **Resources** generally means that the job is next up to be run in its partition (queue).

The code **Priority** means that there are one or more jobs of higher priority waiting in the queue.  Once your job becomes the highest priority for its partition, the reason will change to Resources, and then when the next open slot becomes available, it will run.  (The priority of your job is partially determined by how long it has been waiting, so over time, your job will move to the front of the queue.)

These two reasons occur in the normal operation of SLURM, and no action is required.  Basically, you're just seeing your job wait its turn to be scheduled.

(One thing to keep in mind is that there may be several reasons why your job is not currently running.  SLURM will only display one of them.)

## Reason Code: ReqNodeNotAvail

This indicates that the compute nodes needed for your job are not available.  In our environment, the most likely reason for seeing this is that there is a **maintenance event scheduled**, and there is insufficient time remaining in which to run your job.  So, for example, if there is a maintenance event scheduled to start in ten days, and you submit a job with a requested time limit of fourteen days, your job will show this reason code.  After the maintenance event is complete and SLURM scheduler is restarted, it will be eligible to run.

You can see the upcoming scheduled maintenance events here: [Scheduled Maintenance Windows]({% link docs/scheduled_maintenance.md %}), and they are announced on `talapas-l`.  You can also observe current maintenance reservations with this command

`scontrol show reservation`

**In general, you will want to choose a conservative time limit for your job, a value somewhat longer than you think the job will take, but not a lot longer.**  This will help you avoid needless waits due to scheduled maintenance and will increase the odds of your job running sooner in general.  Use the `--time` flag to specify the job's time limit; if you don't, the job will be given the default value, which is usually the maximum for the partition.  See the [[Quick Start Guide]] for more details.

It's possible to reduce the time limit for a queued job using a command like this

`scontrol update jobid=1234567 timelimit=2-12:00:00`

This would reduce the limit to two days and twelve hours.  This might allow you to squeeze a job in before the maintenance event.

## Other Reason Codes

There are a large number of other reason codes, all documented on the [squeue man page](https://slurm.schedmd.com/squeue.html).  If your job is waiting for a reason that you don't understand, open a ticket, and we will look into it.  In some cases, the SLURM software misbehaves, etc., and action on our part may be necessary to correct the situation.
