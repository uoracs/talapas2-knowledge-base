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

Step 1. From the default Globus File Manager page, click on the 'Collections' button in the left pane. Recently accessed Collections are displayed.

![Globus File Manager Page](../../../../../assets/images/globus_collections.png)

Step 2. Select the Collection which contains the data to be shared. The example below shows the 'University of Oregon - CephFS research storage' Collection details.

![Globus File Manager Page](../../../../../assets/images/globus_cephfs_collection_detail.png)

Step 3. Click on the 'Collections' tab in the top ribbon to display Guest Collections. The example below shows none have been created.

Step 4. Click 'Add Guest Collection' button in the top right to create a new Guest Collection.

![Globus File Manager Page](../../../../../assets/images/globus_cephfs_collection_guest_collection.png)

Step 5. Setup the Guest Collection. Click the 'Browse' button and select the top level Directory for the Guest Collection. All files and folders under this will be shared. Enter necessary information associated with this Guest Collection.

[!NOTE]
Notice the checkbox to 'Force encryption on tranfers to and from this collection'.
Click 'view more fields' to add more information and settings to the Guest Collection.

![Globus File Manager Page](../../../../../assets/images/globus_cephfs_collection_guest_collection_settings.png)

Step 6. Click 'Create Collection' button.

Step 7. In the Permissions tab of the Guest Collection, click the 'Add Permissions - Share With' button.

![Globus File Manager Page](../../../../../assets/images/globus_cephfs_racs_t1_collection.png)

Step 8. Setup permissions and share. The default Path displayed is '/' which is mapped to the top level Directory which was set in Step 5. Select 'Share With' user, Email notification, and Permissions, then click 'Add Permission'. Select 'Add Another Permission' as needed.

![Globus File Manager Page](../../../../../assets/images/globus_cephfs_racs_t1_add_perm.png)

To modify and delete permissions or share with additional collaborators, repeat Step 1. Then select 'Shareable By You' in the top ribbon, select the Guest Collection, then repeat Step 7.

![Globus File Manager Page](../../../../../assets/images/globus_collections_shared_by_you.png)
