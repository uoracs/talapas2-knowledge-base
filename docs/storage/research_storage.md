---
layout: default
title: Research Storage
parent: Storage
nav_order: 3
---

# Large-Scale Research Storage (LSRS)

The Large-Scale Research Storage system RACS operates is backed by a [Ceph](https://en.wikipedia.org/wiki/Ceph_(software)) cluster offering approximately 1PB of storage in two modalities: file/posix and object/S3. Storage on this system is can be purchased by any UO researcher at a price of **$35/TB/yr**, billed annually at the beginning of each fiscal year (i.e. July 1st) in 1TB chunks. To purchase storage allocations on the research storage system, please submit a "Research Storage Request" on our [Service Desk](https://hpcrcf.atlassian.net/servicedesk/customer/portal/1). In your purhcasing ticket, you must specify if you would like file/posix storage or object/S3 storage.

File storage organizes data in a hierarchical system of files and folders, making it intuitive for users and applications that expect a traditional directory structure. It’s well-suited for workloads that require fast read/write access to relatively small files, such as databases or shared drives, and can be mounted on external systems. Object storage, on the other hand, stores data as objects in a flat address space, each with its own unique identifier and metadata. This makes it highly scalable and efficient for managing large volumes of unstructured data like backups, media, and research datasets.

The ways of interacting with your storage will be depend on if you chose to use Object vs. File storage, and they are enumerated under the associated headings below.

## CephFS File Storage

* **[Globus]({% link docs/storage/transferring_data/globus/globus.md %})**: The preferred and fastest method of transferring data and file browsing (web interface: app.globus.org)
  * After authentication, navigate to the File Manager
  * Within the File Manager, in Collection, search for the Research Storage CephFS Collection named: `University of Oregon - CephFS Research Storage`
  * This will bring you to the Path `/cephfs/`, under cephfs click on your research storage space name
  * 100 Gbps transfer speed from the data transfer node
* **Talapas Login Nodes**: From the Talapas login nodes all **file storage** on the Research Storage system is mounted at `/cephfs/`
  * Each group's storage space is mounted at `/cephfs/<GROUP_NAME>/` on all Talapas login nodes (Note that the storage group name may or may not be the same as your PIRG name)
  * This mounted directory is **not** accessible from Talapas compute nodes as this space is not intended for compute I/O
  * Only 10 Gbps transfer speed from the login nodes, use Globus for very large transfers that need additional speed
* **Local MacOS Device**: Through the Finder app
  * In the Finder ribbon, select Go, then Connect to Server…
  * Enter, `smb://ceph-smb.uoregon.edu/<GROUP_NAME>`
  * In the Authentication pop-up
    * select Registered User
    * in Username text field enter your duckid
    * in Domain text field enter ad.uoregon.edu (if required)
    * in Password text field enter your password
    * click Connect
  * This method is only meant for file browsing
* **Local Linux Device**: using the [Nautilus](https://github.com/GNOME/nautilus) GNOME File browser and/or gio mounting
  * For RHEL, Centos, Rocky flavors, install 5 packages
    * Run the command, `dnf install cifs-utils samba-client nautilus gvfs-fuse gvfs-smb`
  * Enter the command, `nautilus`
    * In the window, click Other Locations
    * In the Connect to Server text field enter `smb://ceph-smb.uoregon.edu/<GROUP_NAME>`, click Connect
    * In the Authentication pop-up
      * select Registered User
      * in Username text field enter your duckid
      * in Domain text field enter ad.uoregon.edu
      * in Password text field enter your password
      * click Connect
  * This method is only meant for file browsing
  * Mount with gio
    * Run the command, `gio mount smb://ad.uoregon.edu\;<DUCKID>@ceph-smb.uoregon.edu/<GROUP_NAME>`
      * Enter your duckid password
    * Access the mount under the directory `/run/user/UID`, where UID is your logged in user ID
      * `cd /run/user/$(id -u)/gvfs/'smb-share:domain=ad.uoregon.edu,server=ceph-smb.uoregon.edu,share=<GROUP_NAME>,user=<DUCKID>'`
      * Note: this method has only been tested on a Linux machines bound to UO Active Directory (AD).

## S3 Object Storage

* **[Globus]({% link docs/storage/transferring_data/globus/globus.md %})**: The preferred and fastest method of transferring data and file browsing (web interface: app.globus.org)
  * After authentication, navigate to the File Manager
  * Within the File Manager, in Collection, search for the Research Storage Object S3 Collection named: `University of Oregon - S3 Object Research Storage`
  * This will bring you to the root directory where you can see all buckets you are the owner of
  * If you are not the owner of a bucket, but still have permissions to the bucket -- it will not appear here. You will be able to navigate to the path of that bucket in the path dialog box
  * 100 Gbps transfer speed from the data transfer node
* **[RClone]({% link docs/storage/transferring_data/rclone.md %})**: From any unix based OS
* **[CyberDuck](https://cyberduck.io/)**: Windows or MacOS machines
