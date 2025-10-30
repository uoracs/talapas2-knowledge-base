---
layout: default
title: Transfer files between Collections
nav_order: 3
parent: Globus
grand_parent: Transferring Data
ancestor: Storage
---

# Transfer files between Globus Collections

Globus file transfers are fast, secure, reliable including automatic retries and integrity checks. They can span across University of Oregon Collections or Collections at other institutions.

Step 1.  Open a 2 panel File Manager window by clicking the middle 'Panels' button in the top right corner of the File Manager window.
Designate one panel for the source Collection and the other for the destination Collection.

![Globus File Manager Page](../../../../../assets/images/globus_filemanager_2_panels.png)

Step 2. Connect to the source Collection and navigate to the desired file or folder, check the box to select it. Connect to the destination Collection and navigate to the destination folder.

The example below shows the Talapas2 Collection is in left panel at path '/projects/racs/shared' with the folder 'Apptainer' selected. The right panel shows the CephFS research storage Collection at path '/cephfs/racs'

![Globus File Manager Page](../../../../../assets/images/globus_filemanager_transfer.png)

{: .note }
Click the 'Transfer & Timer Options' arrow for more transfer settings and to create a schedule.

![Globus Transfer and Sync](../../../../../assets/images/globus_filemanager_transfertimer_options.png)

Step 3. Submit a data transfer job by clicking the 'Start' button in the source Collection panel.

{: .note }
The arrow of the Start button points to the destination Collection.

At the completion of the transfer an email is sent with summary information.

Click the 'Activity' button in the left pane to check the status of current or past data transfers.
