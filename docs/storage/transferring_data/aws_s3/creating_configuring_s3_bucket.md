---
layout: default
title: Creating and Configuring an AWS S3 Bucket
nav_order: 1
parent: AWS S3
grand_parent: Transferring Data
---

# Creating and Configuring an AWS S3 Bucket

There are many ways to use AWS S3, but for this simple example, you’ll just need to create two resources: **IAM User** and **S3 Bucket**.

## Creating an IAM User

Navigate to the IAM service using the AWS web console.

On the left, click **Users**.

![IAM USER STEP 1](../../../../../assets/images/iam_user_step1.png)

Here, you can see any existing IAM Users for your AWS account.

Click **Create User**.

![IAM USER STEP 2](../../../../../assets/images/iam_user_step2.png)

Give your IAM User a name. I typically match the name closely to the bucket I plan to give it access to.

![IAM USER STEP 3](../../../../../assets/images/iam_user_step3.png)

Since we cannot use groups in the bucket policy we’ll be creating later, we can select the option to **Attach policies directly**.

![IAM USER STEP 4](../../../../../assets/images/iam_user_step4.png)

On the next screen, I like to tag my resources with some common value. For this example, I’ll use `project: myproject`. Then click **Create user**.

![IAM USER STEP 5](../../../../../assets/images/iam_user_step5.png)

Next, we need to create access keys for this user.

![IAM USER STEP 6](../../../../../assets/images/iam_user_step6.png)

Select the **Security credentials** tab.

![IAM USER STEP 7](../../../../../assets/images/iam_user_step7.png)

Scroll down and click **Create access key**.

![IAM USER STEP 8](../../../../../assets/images/iam_user_step8.png)

Select **Other** for the type of key, we just want a plain access key.

![IAM USER STEP 9](../../../../../assets/images/iam_user_step9.png)

On this next page, make sure to copy down the **Access key** and the **Secret access key** to a secure location such as a password manager. After this page, you can no longer see the secret key. When you have them, click **Done**.

![IAM USER STEP 10](../../../../../assets/images/iam_user_step10.png)

The last piece of information you’ll need is the **ARN** (Amazon Resource Name) of the IAM User. Copy this down somewhere as you’ll need to paste it into the bucket policy soon.

![IAM USER STEP 11](../../../../../assets/images/iam_user_step11.png)

## Creating an S3 Bucket

Now that your IAM User is created and configured, we can create an S3 bucket and attach a policy that allows that user to read/write all data in the bucket.

From the service catalog, select **S3**.

You’ll see a listing of all your buckets. Click **Create bucket**.

![S3 BUCKET STEP 1](../../../../../assets/images/s3_bucket_step1.png)

Give the bucket a name that conforms to the naming policy they mention next to the field. I’ll use `uomyproject`.

![S3 BUCKET STEP 2](../../../../../assets/images/s3_bucket_step2.png)

Leave all the other settings as defaults. I chose to add the `project: myproject` tag to this bucket as well.

![S3 BUCKET STEP 3](../../../../../assets/images/s3_bucket_step3.png)

Once your bucket is created, you’ll be back at the S3 bucket list. Click on your new bucket to configure it.

![S3 BUCKET STEP 4](../../../../../assets/images/s3_bucket_step4.png)

We need to add the IAM user to the bucket policy. Click the **Permissions** tab.

![S3 BUCKET STEP 5](../../../../../assets/images/s3_bucket_step5.png)

Scroll down to the **Bucket policy** section and click **Edit**.

![S3 BUCKET STEP 6](../../../../../assets/images/s3_bucket_step6.png)

This is the policy for my bucket. You’ll need to change a few elements in this policy:

- The `AWS` field needs to be your **IAM User ARN** you copied earlier
- The two `Resource` entries should use your **Bucket name**

You can see for this example, my **IAM User ARN** is `arn:aws:iam::492329369658:user/uomyprojects3user` and my **Bucket name** is `uomyproject`.

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::492329369658:user/uomyprojects3user"
            },
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::uomyproject",
                "arn:aws:s3:::uomyproject/*"
            ]
        }
    ]
}
```

Save the policy.

## Accessing your S3 Bucket

See [Accessing your S3 files via awscli]({% link docs/storage/transferring_data/aws_s3/accessing_files_awscli.md %}) or [Accessing your S3 Buckets via rclone]({% link docs/storage/transferring_data/aws_s3/accessing_s3_bucket_rclone.md %}) on how to easily access your S3 bucket files.

See [Mounting an AWS S3 Bucket to your Filesystem]({% link docs/storage/transferring_data/aws_s3/mounting_s3_bucket.md %}) on how to mount your S3 bucket to your filesystem.
