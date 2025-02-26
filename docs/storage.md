---
layout: default
title: Storage
nav_order: 7
---

# Storage

Here is information on the storage available to Talapas users.

## Layout

See the [Directory Structure]({% link docs/directory_structure.md %}) documentation page.

## Accounting

User home and PIRG projects storage usage on Talapas is tracked using quotas.

## GPFS

The primary storage device for Talapas is an IBM Elastic Storage System. The filesystem is mounted at `/gpfs` on all nodes in the cluster and provides 3.1 [petabytes](https://en.wikipedia.org/wiki/Petabyte "https://en.wikipedia.org/wiki/Petabyte") of storage using [GPFS (General Parallel File System)](https://en.wikipedia.org/wiki/IBM_General_Parallel_File_System "https://en.wikipedia.org/wiki/IBM_General_Parallel_File_System").

## Local Storage

Each compute node is equipped with a local SSD for the operating system as well as providing `/tmp` for local scratch space if desired. This local storage is relatively small and requires a step in your job workflow to copy results off (presumably to your PIRG project space) and remove old data. Local disks vary in size depending on the node type and generation. See the [Partition List]({% link docs/partition_list.md %}) page for more information.
