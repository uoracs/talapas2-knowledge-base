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

RACS operates three different Globus endpoints all connected to UO's network through fast 100 gigabit connections:

- **Talapas2 Endpoint**: The endpoint connected to the GPFS filesystem directly on Talapas
- **CephFS Research Storage**: The endpoint for POSIX-like storage on the Large-Scale Research Storage system
- **S3 Object Research Storage**: The endpoint for S3-like Object storage on the Large-Scale Research Storage system
