---
layout: default
title: Storage
nav_order: 7
has_children: true
permalink: /docs/storage
---

# Storage

RACS offers two storage systems for researchers to store their data. The first is directly on Talapas's GPFS shared filesystem where all Talapas users will have a small free quota of hot/warm storage, and secondly on the Large-Scale Research Storage (LSRS) system that researchers can purchase cold storage allocations.

## Talapas Storage

The primary storage device for Talapas is an IBM Elastic Storage System. The filesystem is mounted at `/gpfs` on all nodes in the cluster providing roughly 3 [petabytes](https://en.wikipedia.org/wiki/Petabyte "https://en.wikipedia.org/wiki/Petabyte") of storage using [GPFS (General Parallel File System)](https://en.wikipedia.org/wiki/IBM_General_Parallel_File_System "https://en.wikipedia.org/wiki/IBM_General_Parallel_File_System"). Storage on Talapas is grouped into three different areas, each with different purposes as follows:

* **Home Directories**: Each user of Talapas as their own home directory at `/home/<USER>/` with a 250GB quota at no cost. This space is ideal for users to install their own software in or to store personal data/work that do not need to regularly share with other Talapas users.
* **PIRG Project Directories**: Each PIRG on Talapas has their own project directory at `/projects/<PIRG>/` with a 2TB quota at no cost. This is where any data and work from shared projects among your group should live, and it will be accessible to all members of the PIRG. If your group requires additional **fast** (i.e. on GPFS) storage, you can purchase additional quota at a rate of **$XX/TB/yr**, billed annually at the beginning of each fiscal year and prorated for allocations purchased during the fiscal year.
* **Scratch Directories**: Each PIRG on Talapas has a scratch directory at `/scratch/<PIRG>/` with a 20TB quota at no cost. This space is meant for **hot** storage for data that you are accessing often. The scratch space has a **strict 90-day purge** policy where contents will regularly be deleted once it has not been accessed in the previous 90 days.

{: .note }
All files stored in your PIRG's `/scratch/<PIRG>/` directory **must** have group ownership set to your PIRG's group name (i.e. `is.racs.pirg.<PIRG>`) and **not** have the group set to "uoregon".

To purchase additional PIRG project directory quota or request a larger quota on your research groups scratch directory, please submit a ticket to our [Service Desk](https://hpcrcf.atlassian.net/servicedesk/customer/portal/1).

{: .warning }
**You are responsible for backing up all of your data on Talapas.  This data is not backed up by RACS.**
Some snapshotting is performed for all directories except for the host temporary directory, and in some cases lost files can be recovered from a snapshot.  This cannot be relied on as a backup, however.

### Layout

See the [Directory Structure]({% link docs/storage/directory_structure.md %}) page for more details on the Talapas's filesystem layout.

### Accounting and Billing

User home and PIRG projects storage usage on Talapas is tracked using quotas, with up-to-date usage numbers provided to each user upon logging in as a message of the day. Storage is purchased in 1 TB allotmants and is billed up-front at the beginning of each fiscal year by allocations and not usage.

### Local Node Storage

Each compute node is equipped with a local SSD for the operating system as well as providing `/tmp` for fast local scratch space if desired. This local storage is relatively small and requires a step in your job workflow to copy results off (presumably to your PIRG project space) and remove old data. The `/tmp` directory on each node's local SSD will be cleared of all your data at the completion/end of your SLURM jobs, so make sure and copy over any data you need that is written here within your jobs. Local disks vary in size depending on the node type and generation. See the [Partition List]({% link docs/partition_list.md %}) page for more information.

## Large-Scale Research Storage (LSRS)

RACS also operates a separate storage system outside of Talapas's filesystem for researchers across UO (not just Talapas users) for warm/cold storage, running on a Ceph cluster that provides a total of 1 petabtye of storage. Research groups can purchase storage allocations on the LSRS system in chunks of 1TB at a price of **$35/TB/yr**. This is billed annually at the beginning of each fiscal year (July 1st - June 30th), with allocations purchased during the year being prorated.

To purchase storage allocations on the LSRS system, please submit a "Research Storage Request" on our [Service Desk](https://hpcrcf.atlassian.net/servicedesk/customer/portal/1).

The LSRS system is connceted to Talapas's network and the data-transfer nodes with fast 100gb connections providing quick speeds for transfering data to/from Talapas's filesystem. The method for transferring files to/from the LSRS will be through [Globus](https://www.globus.org/), which will be able to quickly perform data transfers between personal computers, cloud providers, RACS's two storage systems, and even collaborators at outside institutions. Read more about Globus in our documentation pages on Data Movement: [Globus]({% link docs/storage/transferring_data/globus/globus.md %}).

{: .warning }
**This data is not backed up by RACS.** If you require this data to be backed up to another place in addition to the LSRS, you must do this yourself. This can be done easily through automated Globus transfers, and RACS can help users set this up if requested.


If your research group is looking for archival storage, as mandadated by certain grants and funding sources, we reccomend using AWS Glacier. Please submit a ticket if you need help obtaining an AWS account for Glacier archival storage. UO Information services also has a very useful tool that you can use to find the best storage solution for your specific use case.
