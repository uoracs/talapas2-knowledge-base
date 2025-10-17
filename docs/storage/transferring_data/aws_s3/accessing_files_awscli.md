---
layout: default
title: Accessing your S3 files via awscli
nav_order: 3
parent: AWS S3
grand_parent: Transferring Data
---

# Accessing your S3 files via awscli

Amazon S3 (Simple Storage Service) is a highly scalable, secure, and durable cloud storage service for storing and retrieving data. It uses "buckets" to organize objects and offers multiple storage tiers to optimize costs based on access needs. S3 is a great option for backups, data archiving, application hosting, and big data analytics. Amazon S3 an object storage service that offers industry-leading scalability, data availability, security, and performance. You can use Amazon S3 to store and retrieve data at any time, from anywhere.

This article assumes that you have created an AWS S3 bucket and are either the owner **or** have access rights to the bucket. If you have not created an AWS S3 bucket, please see our [Creating and Configuring an AWS S3 Bucket]({% link docs/storage/transferring_data/aws_s3/creating_configuring_s3_bucket.md %}) page.

## Loading the `aws-cli` module

In order to access S3 buckets from Talapas, one available method would be via the aws-cli tool that has been built on talapas for users. To load the module, run the following command:

`$ module load awscli/2.22.5`

In order to to have the aws-cli authenticate access to S3 buckets, you will have to run the `aws configure` command:

`$ aws configure`

This command will prompt you to enter a bucket key, secret bucket key and a S3 bucket region in order to create two authentication files: `credentials` and `config`; Both of which are stored in `$HOME/.aws`

{: .note }
**If you do not have a key/secret key pair,** then please reference the creating keys step in the [Creating and Configuring an AWS S3 Bucket]({% link docs/storage/transferring_data/aws_s3/creating_configuring_s3_bucket.md %}) documentation.

`aws configure` will walk you through 4 input fields in order to create your `.aws` directory and corresponding files.

![AWS S3 Terminal 1](../../../../../assets/images/aws_s3_term1.png)

Once completed, you should now have a `.aws` directory as well as two files within `.aws` in your `$HOME` directory as seen below:

![AWS S3 Terminal 2](../../../../../assets/images/aws_s3_term2.png)

After completing the `aws configure` setup, you should now have access to the AWS S3 buckets that are owned or available to you.

## Seeing available `S3` buckets

To see what buckets you have access to, you can go ahead and run the `aws s3 ls` command. This will return a list of all available S3 buckets by name. This will return the same list of buckets as seen from your AWS S3 console.

**AWS S3 Console:**
![AWS S3 Console](../../../../../assets/images/aws_s3_console.png)

**Talapas view:**
![AWS S3 Terminal 3](../../../../../assets/images/aws_s3_term3.png)

## Next steps

From here, you now have access to your AWS S3 buckets and can perform a variety of different commands in order to move data. AWS has some pretty verbose documentation detailing how to move files in a variety of different ways.

## Recusivly copying data directory and all of its sub-contents

If you would like to move data within a directory (and all sub-directories), you can use the following command with a `--recursive` flag in order to achieve this.

`$ aws s3 cp --recursive s3://my-bucket-name/subfolder/ /home/USER/destination-directory/`
