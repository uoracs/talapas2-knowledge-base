---
layout: default
title: Scheduled Maintenance Windows
nav_order: 11
---

# Scheduled Maintenance Windows

The cluster will be unavailable during the time frames below with past (i.e. completed) windows highlighted in red and upcoming windows in blue.

<table>
  <tr>
    <th>Starting Date and Time</th>
    <th>Ending Date and Time</th>
  </tr>
  <tr>
    <td style="background-color:#ffb3c1">7/9/2024 @ 9am</td>
    <td style="background-color:#ffb3c1">7/9/2024 @ 9pm</td>
  </tr>
    <tr>
    <td style="background-color:#ffb3c1">9/17/2024 @ 8am</td>
    <td style="background-color:#ffb3c1">9/19/2024 @ 5pm</td>
  </tr>
  <tr>
    <td style="background-color:#ffb3c1">3/25/2025 @ 9am</td>
    <td style="background-color:#ffb3c1">3/27/2025 @ 5pm</td>
  </tr>
  <tr>
    <td style="background-color:#ffb3c1">9/23/2025 @ 9am</td>
    <td style="background-color:#ffb3c1">9/25/2925 @ 5pm</td>
  </tr>
  <tr>
    <td style="background-color:#caf0f8">12/15/2025 @ 9am</td>
    <td style="background-color:#caf0f8">12/19/2025 @ 5pm</td>
  </tr>
    <tr>
    <td style="background-color:#caf0f8">6/15/2026 @ 9am</td>
    <td style="background-color:#caf0f8">6/19/2026 @ 5pm</td>
  </tr>
    <tr>
    <td style="background-color:#caf0f8">12/14/2026 @ 9am</td>
    <td style="background-color:#caf0f8">12/18/2026 @ 5pm</td>
  </tr>
</table>

## SLURM Maintenance Window Reservation

When a maintenance window starts, **all** running SLURM jobs will be cancelled, with the job queue preserved so that pending jobs will start once the cluster is online.

Leading up to the start of the maintenance outage, all jobs that cannot be completed before the beginning of the maintenance window will be **held in the queue** until the cluster comes back online. This is done to prevent users from starting long-running jobs that would be cancelled before they finish when the cluster goes down. That is if you submit a job with the requested time set to 24 hours or a full day (i.e. `--time=1-00:00:00`) less than 24 hours before the maintenance window starts, then your job will remain in the queue and will wait to start until the cluster comes back online at the end of maintenance.

This is often what you'd want. But, sometimes you might want a job to start right away, even if the entire optimal running time is not available. You can specify this using the `--time-min` flag to specify a minimum acceptable time limit for the job.

```bash
#SBATCH --time=0-8:00:00
#SBATCH --time-min=0-1:00:00
```

Using the above flag, you'll normally get a time limit of eight hours. But, if there are reservations that would delay the start of your job, SLURM will consider any time limit down to one hour to be acceptable and start the job immediately. (SLURM will prefer the largest available time limit.)
