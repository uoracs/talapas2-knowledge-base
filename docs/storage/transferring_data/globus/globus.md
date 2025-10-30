---
layout: default
title: Globus
nav_order: 2
has_children: true
parent: Transferring Data
grand_parent: Storage
permalink: /docs/storage/transferring_data/globus
---

# Globus

Globus is a secure, reliable, and high-performance service for transferring and sharing large research datasets across institutions, computing clusters, and cloud storage systems. It simplifies the process of moving data by handling authentication, encryption, fault tolerance, and automatic retries, ensuring transfers are both fast and dependable. Researchers can benefit from Globus’s ability to move terabytes of data without manual monitoring, resume interrupted transfers, and provide controlled access for collaborators. Globus can be used through the web-based GUI or through a feature-rich CLI or python SDK that enable complex research workflows through scripting.

[Globus](https://www.globus.org/)

RACS operates the Globus RACS-Endpoint which currently contains four different Globus managed Collections, all through dedicated data transfer nodes connected to UO's network through fast 100 gigabit connections:

- **University of Oregon - CephFS research storage**: The collection connected to the research storage file store for POSIX-like data access. Allows for data transfers to and from your CephFS research storage volumes.
- **University of Oregon - Ceph S3 research storage**: The collection connected to the research storage object store for S3-like data access. Allows for data transfers to and from your Ceph S3 research storage volumes.
- **University of Oregon - Dropbox**: The collection connected to the University of Oregon Dropbox plan. Allows for data transfers to and from your UO Dropbox account.
- **University of Oregon - Talapas2**: The collection connected to the GPFS filesystem directly on the Talapas HPC cluster. Allows for data transfers to and from your /home or /projects directories.

[!NOTE]
When using Globus, disconnect from the UO VPN.
