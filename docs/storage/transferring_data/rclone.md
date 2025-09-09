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
- [DropBox]({% link docs/storage/transferring_data/dropbox.md %})
- [Google Drive]({% link docs/storage/transferring_data/google_drive.md %})
- [UO Research Storage]({% link docs/storage/research_storage.md %})
