---
layout: default
title: How-To Create a Globus Guest Collection
nav_order: 5
parent: Globus
grand_parent: Data Movement
---

# How-To Create a Globus Guest Collection

**What is a Globus Guest Collection?**

A Globus Guest Collection will allow you share your files and directories to collaborators that don't have access to Talapas or regular linux permissions to read and write data. You can have any number of guest collections, though I recommend only having **one or two collections (user/project) and multiple shares from those collections** (explained below).

Create a Globus Guest Collection:
Navigate to the [Globus Transfer Page](https://app.globus.org/file-manager), then click "Collections" on the left-side toolbar.

If you've recently used our "University of Oregon - Talapas2" collection, it should show up in the list. If not, you'll need to uncheck "Recently Used", then search for "Talapas2". You should find and click on the "University of Oregon - Talapas2" managed endpoint.

Alternatively, you can click this link to go right to it: [Talapas2 Globus](https://app.globus.org/file-manager/collections/1b22bc07-95c5-47eb-8e62-97da36c46296/overview)

![Globus Talapas 2 Collection](../../../../assets/images/globus_t2_collection.png)

Click the "Collections" tab on the tab bar of this endpoint.

![Globus User Collections](globus_t2_user_collections.png)

Click the "Add Guest Collection" button on the top-right.

This guest collection will serve as the filesystem root of all the shares you want to create.

If you're sharing data from your home directory, I recommend creating a `~/globus` directory on Talapas to serve as the collection base (`mkdir -p ~/globus`).

If this is project data you want to share, I recommend creating `/projects/yourproject/globus`, or `/projects/yourproject/shared/globus` and using that path (`mkdir -p /projects/yourproject/globus`).

Use that path in the setup of your guest collection.

Please include your username in the Display Name field if it's a home guest collection, or your project name if it's a project guest collection, then click "Create Collection".

![Globus Create New GC](../../../../assets/images/globus_create_new_gc.png)

You should now see your collection listed

![Globus Show New Collection](../../../../assets/images/globus_show_new_gc.png)

Click on your new guest collection, then click the "Permissions" tab at the top.

![Globus GC Permissions](../../../../assets/images/globus_gc_permissions.png)

This is the base path of your guest collection. By default, your user and the "talapas2" identity have access to the files here. While you could directly add permissions to this base path, I recommend creating directories inside this space and setting permissions on those.

For example, I'll set up two shares: One that allows my external collaborator buddy to grab files, and another that allows **anyone** to read the files.

Before I create the share in Globus, I first have to create the two subdirectories on Talapas that will be the paths for sharing the data.

`mkdir -p ~/globus/coding_collab_with_freddy`

`mkdir -p ~/globus/public`

These will be my two shares.

First, click the "Add Permissions - Share With" button.

![Globus Add Permissions](../../../../assets/images/globus_add_permissions.png)

Click the Browse button, and you should be able to see all the directories in your `~/globus` base path. In my case, I see "coding_collab_with_freddy" and "public". I'll create the coding collab share first, so I click on that directory.

![Globus Share With](../../../../assets/images/globus_share_with.png)

I only plan to share this directory with Freddy, so I'll choose to share with a "user". You can also create groups of users inside Globus, then share to that group: [How to Manage Globus Groups](https://docs.globus.org/guides/tutorials/manage-identities/manage-groups/).

Enter their email address in the box and click on the correct user in the dropdown. **Note: They must already have a globus account (free), you cannot add unregistered users.** You can choose to send an email notifying them that you've added them to the share.

Lastly, you can choose to give them write access, or just read access.

Click Add Permission.

Now you should see your new share in the list (_Freddy didn't have a Globus account, so pretend Mark is Freddy_ 🙂 _)_

From now on, **any data in `~/globus/coding_collab_with_freddy/` is readable by Mark.**

![Globus Shared With List](../../../../assets/images/globus_shared_with_list.png)

Next, I want to create a public share so I can allow access for **anyone** to some set of data. I'll follow the same steps as before, but I'll select the "public" directory I created, and select the "public" option in the Share With section. Then click "Add Permission".

![Globus Anyone Permissions](../../../../assets/images/globus_anyone_permissions.png)

Now I have two shares, one for sharing some code with Mark, and another for letting anyone in the world download files in my `~/globus/public` directory.

![Globus All permissions](../../../../assets/images/globus_all_permissions.png)
