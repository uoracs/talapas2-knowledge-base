---
layout: default
title: How-To Track Submitted Jobs
parent: How-To Articles
nav_order: 10
---

# How-To Track Submitted Jobs

When submitting jobs to Talapas using SLURM, tracking their progress can become tedious, especially when using manual commands like `squeue` to monitor the queue. Using SLURM's built-in email notification options can streamline this process, providing automated updates about your job status without needing to manually check or run expensive watch scripts.

## How to Use `#SBATCH --mail-type` and `#SBATCH --mail-user`

To enable email notifications, include the following options in your SLURM job submission script:

### Example

```bash
#!/bin/bash -l
#SBTACH --account=<myPIRG>
#SBATCH --partition=preempt
#SBATCH --job-name=testSlurmEmail
#SBATCH --output=testSlurm.out
#SBATCH --error=testSlurm.err
#SBATCH --time=0-00:01:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=500M
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=flopez2@uoregon.edu
```

### Key Options

1. `--mail-type`**:**
    - Specifies the types of job events for which you want notifications. Common values include:
        - `BEGIN`: Notify when the job starts.
        - `END`: Notify when the job completes.
        - `FAIL`: Notify if the job fails.
    You can use multiple types, separated by commas (As seen in the above example)
2. `--mail-user`**:**
    - Defines the email address to receive the notifications. Enter your `<duckID>@uoregon` email.

## Why Use `#SBATCH --mail-type` and `#SBATCH --mail-user` over `watch`

1. **Convenience**:
  Instead of frequently running `squeue` to check job statuses, email notifications provide updates directly to your inbox. This saves time and reduces the need for constant monitoring.
2. **Automation**:
  Notifications are sent automatically when specific events occur, such as job start (`BEGIN`), completion (`END`), or failure (`FAIL`). This ensures you never miss critical updates about your job.
3. **Efficiency**:
  Email notifications allow you to focus on other tasks while being informed about your job’s progress without manual intervention.
4. **Accessibility**:
  If you're away from your primary workstation, emails can be accessed on any device, ensuring you remain informed even when not actively logged into the cluster.

---

## Key Takeaway

Running commands such as `watch` in combination with `squeue` every two seconds can significantly impact the clusters performance. This constant querying generates unnecessary computational and network load, reducing the efficiency of resource allocation and potentially delaying job scheduling for all users. Please, if you would like to track your jobs status, utilize SLURM’s email notifications with `#SBATCH --mail-type` and `#SBATCH --mail-user`.
