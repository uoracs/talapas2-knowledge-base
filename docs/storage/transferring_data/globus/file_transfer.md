---
layout: default
title: File Transfers between Collections
nav_order: 3
parent: Globus
grand_parent: Transferring Data
ancestor: Storage
---

# Transfer files between Globus Collections

Globus file transfers can span across University of Oregon Collections or other research institutions. They are fast, secure, reliable including automatic retries and integrity checks.

Step 1. Open a 2 panel File Manager window, one panel for the source Collection and the other for the destination Collection. Click the middle 'Panels' button in the top right corner of the File Manager window.

![Globus File Manager Page](../../../../../assets/images/globus_filemanager_2_panels.png)

Step 2. Choose a source Collection and navigate to the desired file or folder, check the box to select it. Choose a destination Collection and navigate to the destination folder.

The example below shows the Talapas2 Collection is in left panel at path '/projects/racs/shared' with the folder 'Apptainer' selected. The right panel shows the CephFS research storage Collection at path '/cephfs/racs'

![Globus File Manager Page](../../../../../assets/images/globus_filemanager_transfer.png)

Step 3. Submit a data transfer job by clicking the 'Start' button in the source Collection panel.
[!NOTE]
The arrow of the Start button points to the destination Collection.

Step 4. Click the 'Activity' button in the left pane to check the status of current or past data transfers.

An Email is sent with summary information after the data transfer has completed.

[!NOTE]
Click the 'Transfer & Timer Options' arrow for more transfer settings and creating a schedule.

![Globus Transfer and Sync](../../../../../assets/images/globus_filemanager_transfertimer_options.png)
