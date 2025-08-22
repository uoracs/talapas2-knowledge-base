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
    <td style="background-color:#caf0f8">9/23/2025 @ 9am</td>
    <td style="background-color:#caf0f8">9/25/2925 @ 5pm</td>
  </tr>
</table>

## SLURM Maintenance Window Reservation

When a maintenance window starts, **all** running SLURM jobs will be cancelled, with the job queue preserved so that pending jobs will start once the cluster is online.

Leading up to the start of the maintenance outage, all jobs that cannot be completed before the beginning of the maintenance window will not be allowed to start. This is done to prevent users from starting long-running jobs that would be cancelled before they finish when the cluster goes down. That is if you submit a job with the requested time set to 24 hours or a full day (i.e. `--time=1-00:00:00`) less than 24 hours before the maintenance window starts, then your job will remain in the queue and will wait to start until the cluster comes back online at the end of maintenance.

Make sure and specify the time argument for your SLURM jobs leading up to the outage window with a time limit less than the remaining time before the outage to allow them to start.
