---
layout: default
title: RClone
nav_order: 1
parent: Transferring Data
grand_parent: Storage
permalink: /docs/transferring_data/rclone
---

# RClone

Rclone is a powerful open-source command-line tool that lets you manage, move, and synchronize files across a wide range of cloud storage services and local file systems. It supports over 50 providers—including Google Drive, OneDrive, Dropbox, Box, Amazon S3, and many university or enterprise storage systems—making it a versatile solution for research data management, backups, and collaboration. Rclone works much like rsync, but with added cloud awareness: it can copy files, keep directories in sync, and even handle encryption and bandwidth throttling. By unifying different storage platforms under a single interface, Rclone makes it easy to securely transfer and organize data no matter where it resides.

There is a module for rclone on Talapas that can be loaded by running: `module load rclone`. We have a few tutorials on how to use rclone to transfer data to/from Talapas to a few different other storage providers:

- [AWS S3]({% link docs/storage/transferring_data/aws_s3/accessing_s3_bucket_rclone.md %})
- [Drop Box]({% link docs/storage/transferring_data/dropbox.md %})
- [Google Drive]({% link docs/storage/transferring_data/google_drive.md %})
- [UO Research Storage]({% link docs/storage/research_storage.md %})

## How to Configure Rclone for Ceph S3 Bucket Access

This guide covers configuring rclone to connect to University of Oregons Large-Scale Research Storage Ceph S3 bucket storage solution via Talapas

### Prerequisites

- Rclone installed on your Linux system
- Ceph S3 endpoint URL
- S3 access key and secret key from RACS admin
- Bucket name you want to access

### Important Note
Since there is a single endpoint for accessing bucekts here at the University of Oregon, You will only have to go through the `rclone config` once.
Once the end point is configured, you can then hit and access any future buckets that you are granted access to using the same initial endpoint. The
only difference is that you need to change the name of the bucket you are trying to access.

### Configuration Steps

#### Interactive Configuration

Run the rclone configuration wizard:

```bash
rclone config
```

Follow these steps in the interactive menu:

1. Select `n` for "New remote"
2. Enter a name for your remote (e.g., `ceph-s3`)
3. Select `Amazon S3 Compliant Storage Providers` (usually option 4)
4. Choose `Ceph` (usually option 4)
5. Select `1 / Enter AWS credendtials in the next step`
*Note* The following information is obtained via an email that is sent to you when you are granted access to LSRS for the first time.
6. Enter your configuration details:
   - **Access Key ID**: Your Ceph S3 access key
   - **Secret Access Key**: Your Ceph S3 secret key
   - **Region**: Leave blank or enter your Ceph region
   - **Endpoint**: Your Ceph RadosGW endpoint (e.g., `https://ceph.example.com`)
   - **Location constraint**: Leave blank
   - **ACL**: Leave as default
   - **Storage class**: Leave blank

7. Select `n` when asked about advanced config
8. Test the connection by selecting `y`
9. If the test succeeds, select `y` to save the configuration

#### Manual Configuration

Alternatively, you can manually edit the rclone config file:

```bash
nano ~/.config/rclone/rclone.conf
```

Add a section like this:

```ini
[ceph-s3]
type = s3
provider = Other
access_key_id = YOUR_ACCESS_KEY
secret_access_key = YOUR_SECRET_KEY
endpoint = https://your-ceph-endpoint.com
```

## Testing the Connection

Verify your configuration works by listing buckets:

```bash
rclone lsd ceph-s3:
```

List contents of a specific bucket:

```bash
rclone ls ceph-s3:your-bucket-name
```

### Common Operations

#### Upload files to bucket
```bash
rclone copy /local/path/ ceph-s3:bucket-name/remote/path/
```

#### Download files from bucket
```bash
rclone copy ceph-s3:bucket-name/remote/path/ /local/path/
```

#### Sync directories (one-way)
```bash
rclone sync /local/path/ ceph-s3:bucket-name/remote/path/
```


#### Debug Mode
Run commands with verbose output for troubleshooting:

```bash
rclone -vv ls ceph-s3:bucket-name
```
Your rclone configuration should now be ready to interact with your Ceph S3 bucket. Test thoroughly with non-critical data before using in production environments.
