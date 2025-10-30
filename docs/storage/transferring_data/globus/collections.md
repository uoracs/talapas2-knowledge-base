---
layout: default
title: Connect to Collections
nav_order: 2
parent: Globus
grand_parent: Transferring Data
ancestor: Storage
---

# Connect to a Globus Collection

A Globus Collection is an access point by which a set of data can be managed and used as a source or destination for a data transfer.

RACS operates the Globus RACS-Endpoint which connects the following Collections, all accessible through dedicated data transfer nodes connected to UO's network through 100 GbE.

- **University of Oregon - CephFS research storage**: collection connected to the research storage file store for POSIX-like data access. Allows data transfers to and from your CephFS research storage volumes.
- **University of Oregon - Ceph S3 research storage**: collection connected to the research storage object store for S3-like data access. Allows data transfers to and from your Ceph S3 research storage volumes.
- **University of Oregon - Dropbox**: collection connected to the University of Oregon Dropbox plan. Allows data transfers to and from your UO Dropbox account.
- **University of Oregon - Talapas2**: collection connected to the GPFS filesystem directly on the Talapas HPC cluster. Allows data transfers to and from your /home or /projects directories.

Step 1. In the Globus File Manager landing page, click 'Search' within the Collection text field.

![Globus File Manager Page](../../../../../assets/images/globus_default_filemanager.png)

Step 2. Enter the name of the Collection or some portion of it, such as University of Oregon, in the text field to search all Globus Collections. Click the Collection name to connect.

![Globus File Manager Collections](../../../../../assets/images/globus_filemanager_collection_search.png)
