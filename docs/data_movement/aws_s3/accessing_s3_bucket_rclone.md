---
layout: default
title: Accessing your S3 Buckets via rclone
nav_order: 2
parent: AWS S3
grand_parent: Data Movement
---

# Accessing your S3 Buckets via rclone

`rclone` is a great command-line tool designed for managing and synchronizing files with Amazon S3 and other S3-compatible storage options. It allows you to perform a wide range of tasks such as copying, moving, syncing, and encrypting files between your local system and S3 buckets or between two S3 buckets.

## Configuring `rclone` for S3 buckets

In order to configure rclone to see your AWS S3 buckets and associated data, you will first need to load the `rclone` module.

`$ module load rclone/1.66.0`

After loading the module, you will need to run the interactive configuration script with the following command.

`$ rclone config`

Lucky for us, the people at rclone have created a very explicit document detailing the steps needed to configure an S3 bucket which can be found here: [Amazon S3](https://rclone.org/s3/#configuration)

{: .note }
For this configuration you will **need** your AWS access key credentials. If you need help obtaining this information, please see our [Creating and Configuring an AWS S3 Bucket]({% link docs/data_movement/aws_s3/creating_configuring_s3_bucket.md %}) page or AWS IAM user documentation.

The following was obtained from that document and is exactly the same process one would follow when configuring `rclone` on Talapas:

```bash
No remotes found, make a new one?
n) New remote
s) Set configuration password
q) Quit config
n/s/q> n
name> talapasS3
Type of storage to configure.
Choose a number from below, or type in your own value
[snip]
XX / Amazon S3 Compliant Storage Providers including AWS, ...
   \ "s3"
[snip]
Storage> s3
Choose your S3 provider.
Choose a number from below, or type in your own value
 1 / Amazon Web Services (AWS) S3
   \ "AWS"
 2 / Ceph Object Storage
   \ "Ceph"
 3 / DigitalOcean Spaces
   \ "DigitalOcean"
 4 / Dreamhost DreamObjects
   \ "Dreamhost"
 5 / IBM COS S3
   \ "IBMCOS"
 6 / Minio Object Storage
   \ "Minio"
 7 / Wasabi Object Storage
   \ "Wasabi"
 8 / Any other S3 compatible provider
   \ "Other"
provider> 1
Get AWS credentials from runtime (environment variables or EC2/ECS meta data if no env vars). Only applies if access_key_id and secret_access_key is blank.
Choose a number from below, or type in your own value
 1 / Enter AWS credentials in the next step
   \ "false"
 2 / Get AWS credentials from the environment (env vars or IAM)
   \ "true"
env_auth> 1
AWS Access Key ID - leave blank for anonymous access or runtime credentials.
access_key_id> XXX
AWS Secret Access Key (password) - leave blank for anonymous access or runtime credentials.
secret_access_key> YYY
Region to connect to.
Choose a number from below, or type in your own value
   / The default endpoint - a good choice if you are unsure.
 1 | US Region, Northern Virginia, or Pacific Northwest.
   | Leave location constraint empty.
   \ "us-east-1"
   / US East (Ohio) Region
 2 | Needs location constraint us-east-2.
   \ "us-east-2"
   / US West (Oregon) Region
 3 | Needs location constraint us-west-2.
   \ "us-west-2"
   / US West (Northern California) Region
 4 | Needs location constraint us-west-1.
   \ "us-west-1"
   / Canada (Central) Region
 5 | Needs location constraint ca-central-1.
   \ "ca-central-1"
   / EU (Ireland) Region
 6 | Needs location constraint EU or eu-west-1.
   \ "eu-west-1"
   / EU (London) Region
 7 | Needs location constraint eu-west-2.
   \ "eu-west-2"
   / EU (Frankfurt) Region
 8 | Needs location constraint eu-central-1.
   \ "eu-central-1"
   / Asia Pacific (Singapore) Region
 9 | Needs location constraint ap-southeast-1.
   \ "ap-southeast-1"
   / Asia Pacific (Sydney) Region
10 | Needs location constraint ap-southeast-2.
   \ "ap-southeast-2"
   / Asia Pacific (Tokyo) Region
11 | Needs location constraint ap-northeast-1.
   \ "ap-northeast-1"
   / Asia Pacific (Seoul)
12 | Needs location constraint ap-northeast-2.
   \ "ap-northeast-2"
   / Asia Pacific (Mumbai)
13 | Needs location constraint ap-south-1.
   \ "ap-south-1"
   / Asia Pacific (Hong Kong) Region
14 | Needs location constraint ap-east-1.
   \ "ap-east-1"
   / South America (Sao Paulo) Region
15 | Needs location constraint sa-east-1.
   \ "sa-east-1"
region> 1
Endpoint for S3 API.
Leave blank if using AWS to use the default endpoint for the region.
endpoint>
Location constraint - must be set to match the Region. Used when creating buckets only.
Choose a number from below, or type in your own value
 1 / Empty for US Region, Northern Virginia, or Pacific Northwest.
   \ ""
 2 / US East (Ohio) Region.
   \ "us-east-2"
 3 / US West (Oregon) Region.
   \ "us-west-2"
 4 / US West (Northern California) Region.
   \ "us-west-1"
 5 / Canada (Central) Region.
   \ "ca-central-1"
 6 / EU (Ireland) Region.
   \ "eu-west-1"
 7 / EU (London) Region.
   \ "eu-west-2"
 8 / EU Region.
   \ "EU"
 9 / Asia Pacific (Singapore) Region.
   \ "ap-southeast-1"
10 / Asia Pacific (Sydney) Region.
   \ "ap-southeast-2"
11 / Asia Pacific (Tokyo) Region.
   \ "ap-northeast-1"
12 / Asia Pacific (Seoul)
   \ "ap-northeast-2"
13 / Asia Pacific (Mumbai)
   \ "ap-south-1"
14 / Asia Pacific (Hong Kong)
   \ "ap-east-1"
15 / South America (Sao Paulo) Region.
   \ "sa-east-1"
location_constraint> 1
Canned ACL used when creating buckets and/or storing objects in S3.
For more info visit https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl
Choose a number from below, or type in your own value
 1 / Owner gets FULL_CONTROL. No one else has access rights (default).
   \ "private"
 2 / Owner gets FULL_CONTROL. The AllUsers group gets READ access.
   \ "public-read"
   / Owner gets FULL_CONTROL. The AllUsers group gets READ and WRITE access.
 3 | Granting this on a bucket is generally not recommended.
   \ "public-read-write"
 4 / Owner gets FULL_CONTROL. The AuthenticatedUsers group gets READ access.
   \ "authenticated-read"
   / Object owner gets FULL_CONTROL. Bucket owner gets READ access.
 5 | If you specify this canned ACL when creating a bucket, Amazon S3 ignores it.
   \ "bucket-owner-read"
   / Both the object owner and the bucket owner get FULL_CONTROL over the object.
 6 | If you specify this canned ACL when creating a bucket, Amazon S3 ignores it.
   \ "bucket-owner-full-control"
acl> 1
The server-side encryption algorithm used when storing this object in S3.
Choose a number from below, or type in your own value
 1 / None
   \ ""
 2 / AES256
   \ "AES256"
server_side_encryption> 1
The storage class to use when storing objects in S3.
Choose a number from below, or type in your own value
 1 / Default
   \ ""
 2 / Standard storage class
   \ "STANDARD"
 3 / Reduced redundancy storage class
   \ "REDUCED_REDUNDANCY"
 4 / Standard Infrequent Access storage class
   \ "STANDARD_IA"
 5 / One Zone Infrequent Access storage class
   \ "ONEZONE_IA"
 6 / Glacier storage class
   \ "GLACIER"
 7 / Glacier Deep Archive storage class
   \ "DEEP_ARCHIVE"
 8 / Intelligent-Tiering storage class
   \ "INTELLIGENT_TIERING"
 9 / Glacier Instant Retrieval storage class
   \ "GLACIER_IR"
storage_class> 1
Remote config
Configuration complete.
Options:
- type: s3
- provider: AWS
- env_auth: false
- access_key_id: XXX
- secret_access_key: YYY
- region: us-east-1
- endpoint:
- location_constraint:
- acl: private
- server_side_encryption:
- storage_class:
Keep this "remote" remote?
y) Yes this is OK
e) Edit this remote
d) Delete this remote
y/e/d>y
```

After finishing the `rclone config` process, you should now be able to see the buckets associated with the newly configured remote.

You can verify this by running `rclone lsd <remote-name>:`. An example is shown below:

```bash
[flopez2@login1 rclone]$ rclone lsd talapasS3:
          -1 2024-11-25 14:54:22        -1 mytalapastestbucket
[flopez2@login1 rclone]$
```

This output should match the buckets that can be seen from your AWS S3 console:

![AWS S3 Console2](../../../../assets/images/aws_s3_console2.png)

## Next Steps

From here, you can now see files associated with each configured bucket, move files from the S3 onto Talapas, or move data between buckets on S3. Below are a few examples of moving (very simple data) from S3 to Talapas.

**Example:**

I can perform an `ls` command on my bucket to see the contents. In my case its only one file.

Talapas view:

```bash
[flopez2@login1 rclone]$ rclone ls talapasS3:mytalapastestbucket
      299 test_file.txt
[flopez2@login1 rclone]
```

AWS S3 Console view:
![AWS S3 Console3](../../../../assets/images/aws_s3_console3.png)

From here I can copy the entire bucket (one file in the case) from S3 to Talapas into my current directory with `rclone move s3:<bucket_name>/<directory_path> <destination_path>`.

An example of this can be seen below:

```bash
[flopez2@login1 rclone]$ rclone copy talapasS3:mytalapastestbucket .
[flopez2@login1 rclone]$ ls
test_file.txt
[flopez2@login1 rclone]$
```

{: .note }
`.` means current directory which in my case is `/home/flopez2/test-module/rclone/`

I now have successfully moved all the data in my S3 bucket onto Talapas.

### Option flags you might use in conjunction with `rclone copy`

- `--progress`: Show a progress bar during the upload.
- `--dry-run`: Test the command without actually copying the file.
- `--verbose`: Show detailed information about the upload process.

#### Example with Options

`$ rclone copy /path/to/local/file s3:<bucket_name>/<destination_path> --progress --verbose`

I now have successfully moved all the data in my S3 bucket onto Talapas.
