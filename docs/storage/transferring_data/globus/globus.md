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

Globus is a secure, reliable, and high-performance service for transferring and sharing large research datasets across institutions, computing clusters, and cloud storage systems. It simplifies the process of moving data by handling authentication, encryption, fault tolerance, and automatic retries, ensuring transfers are both fast and dependable. Researchers can benefit from Globus’s ability to move terabytes of data without manual monitoring, resume interrupted transfers, and provide controlled access for collaborators. Globus can be used through the web-based GUI, through a CLI, or python SDK that enable research workflows through scripting.

For more information on Globus visit their website, (https://www.globus.org/)

RACS operates the Globus RACS-Endpoint which connects the following Collections, all accessible through dedicated data transfer nodes connected to UO's network through 100 GbE connections.

- **University of Oregon - CephFS research storage**: collection connected to the research storage file store for POSIX-like data access. Allows data transfers to and from your CephFS research storage volumes.
- **University of Oregon - Ceph S3 research storage**: collection connected to the research storage object store for S3-like data access. Allows data transfers to and from your Ceph S3 research storage volumes.
- **University of Oregon - Dropbox**: collection connected to the University of Oregon Dropbox plan. Allows data transfers to and from your UO Dropbox account.
- **University of Oregon - Talapas2**: collection connected to the GPFS filesystem directly on the Talapas HPC cluster. Allows data transfers to and from your /home or /projects directories.

> [!NOTE]
> It is best to disconnect from the UO VPN when using Globus.
