---
layout: default
title: Guest Collections
nav_order: 4
parent: Globus
grand_parent: Transferring Data
ancestor: Storage
---

# Create a Globus Guest Collection

A Globus Guest Collection is an access point to a set of data for sharing with collaborators either external to the University of Oregon or external to your group.

Step 1. Click the 'Collections' button in the left pane of the Globus window. Recently accessed Collections are displayed. Then select from the displayed list or search for the Collection which contains the data to be shared.

![Globus File Manager Page](../../../../../assets/images/globus_collections.png)

Step 2. The Overview tab of the selected Collection will be displayed. The example below shows the 'University of Oregon - CephFS research storage' Collection Overview tab.

![Globus File Manager Page](../../../../../assets/images/globus_cephfs_collection_detail.png)

Step 3. Click on the 'Collections' tab in the top ribbon.
The example below shows no Guest Collections have been created.

![Globus File Manager Page](../../../../../assets/images/globus_cephfs_collection_guest_collection.png)

Step 4. Click 'Add Guest Collection' button in the top right to create a new Guest Collection.

Step 5. Setup the Guest Collection.

First, click the 'Browse' button and select the top level Directory for the Guest Collection. Files and folders under this Directory path will be shared.

Next, enter information associated with this Guest Collection.

Finally, click the 'Create Collection' button.

{: .note }
Select the checkbox 'Force encryption on tranfers to and from this collection' as needed. Click 'view more fields' to add more information and settings to the Guest Collection.

![Globus File Manager Page](../../../../../assets/images/globus_cephfs_collection_guest_collection_settings.png)

Step 6. The Permissions tab of the Guest Collection is then displayed.

Click the 'Add Permissions - Share With' button.

![Globus File Manager Page](../../../../../assets/images/globus_cephfs_racs_t1_collection.png)

Step 7. Setup permissions and share.

The Path displayed is '/' which is mapped to the top level Directory setup in Step 5.

Select 'Share With' user, Email notification, and Permissions, then click 'Add Permission'.

Select 'Add Another Permission' as needed.

![Globus File Manager Page](../../../../../assets/images/globus_cephfs_racs_t1_add_perm.png)

To modify and delete permissions or share with additional collaborators, repeat Step 1. Then select 'Shareable By You' in the top ribbon, and select the Guest Collection, then repeat Step 7.

![Globus File Manager Page](../../../../../assets/images/globus_collections_shared_by_you.png)
