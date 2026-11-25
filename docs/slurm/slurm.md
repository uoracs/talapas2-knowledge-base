---
layout: default
title: Slurm
nav_order: 5
has_children: true
permalink: docs/slurm
---

# Slurm

## What is Slurm?

The Simple Linux Utility for Resource Management (Slurm) is a cluster management and job scheduling system. We use Slurm to allocate access to resources (i.e. compute nodes, cpus, gpus, and memory), prevent resource conflicts, and ensure fair and equitable access to Talapas resources. Slurm also provides a means of coordinating workflows, establishing job dependencies, and queueing jobs when the system is fully utilized.

## Where can I learn more about Slurm?

Full documentation, quick start guides, and tutorials are on the [Slurm](https://slurm.schedmd.com) website. We have several how-to guides on this site covering several key components of Slurm including the job submission process. A good place to start is [How-To Submit a Batch Job]({% link docs/slurm/how-to_submit_a_batch_job.md %}).

{: .note }
Every Slurm job on Talapas needs an account (your PIRG), and you must specify a partition with `--partition`. See the [Partition List]({% link docs/about_talapas/partition_list.md %}).
