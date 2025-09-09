---
layout: default
title: Google Drive
nav_order: 4
parent: Transferring Data
grand_parent: Storage
---

# Google Drive

Google Drive can be accessed for browsing and data transfers from Talapas login nodes using the process described below. Follow the steps below to configure an rclone remote connection to your Google Drive account.

## Setup a Google Client ID (optional, but recommended)

Google sets a global rate limit per client ID on the number of queries per second allowed. Rclone's default client ID is shared between all rclone users, therefore performance will likely suffer if using it instead of your own.

Follow the instructions to setup your Google client_id:

[https://rclone.org/drive/#making-your-own-client-id](https://rclone.org/drive/#making-your-own-client-id)

The example below configures an rclone remote named “gog-remote”. Your rclone remote can be named can be anything (descriptive is probably better). The name will be used as a command line argument to rclone only.

Substitute my-client-id and my-secret for your own Google client ID and secret.

## Run `rclone config` on a login node

```bash
$ module load rclone/1.52.2
$ rclone config

e) Edit existing remote
n) New remote
d) Delete remote
r) Rename remote
c) Copy remote
s) Set configuration password
q) Quit config
e/n/d/r/c/s/q> n
name> gog-remote
Type of storage to configure.
Enter a string value. Press Enter for the default ("").
Choose a number from below, or type in your own value
 1 / 1Fichier
   \ "fichier"
 2 / Alias for an existing remote
   \ "alias"
 3 / Amazon Drive
   \ "amazon cloud drive"
...
13 / Google Drive
   \ "drive"
Storage> 13
** See help for drive backend at: https://rclone.org/drive/ **

Google Application Client Id
Setting your own is recommended.
See https://rclone.org/drive/#making-your-own-client-id for how to create your own.
If you leave this blank, it will use an internal key which is low performance.
Enter a string value. Press Enter for the default ("").
client_id> <my-client-id>
Google Application Client Secret
Setting your own is recommended.
Enter a string value. Press Enter for the default ("").
client_secret> <my-secret>
Scope that rclone should use when requesting access from drive.
Enter a string value. Press Enter for the default ("").
Choose a number from below, or type in your own value
 1 / Full access all files, excluding Application Data Folder.
   \ "drive"
 2 / Read-only access to file metadata and file contents.
   \ "drive.readonly"
   / Access to files created by rclone only.
 3 | These are visible in the drive website.
   | File authorization is revoked when the user deauthorizes the app.
   \ "drive.file"
   / Allows read and write access to the Application Data folder.
 4 | This is not visible in the drive website.
   \ "drive.appfolder"
   / Allows read-only access to file metadata but
 5 | does not allow any access to read or download file content.
   \ "drive.metadata.readonly"
scope> 1
ID of the root folder
Leave blank normally.

Fill in to access "Computers" folders (see docs), or for rclone to use
a non root folder as its starting point.

Note that if this is blank, the first time rclone runs it will fill it
ID of the root folder
in with the ID of the root folder.

Enter a string value. Press Enter for the default ("").
root_folder_id>
Service Account Credentials JSON file path
Leave blank normally.
Needed only if you want use SA instead of interactive login.
Enter a string value. Press Enter for the default ("").
service_account_file>
Edit advanced config? (y/n)
y) Yes
n) No (default)
y/n> n
Remote config
Use auto config?
 * Say Y if not sure
 * Say N if you are working on a remote or headless machine
y) Yes (default)
n) No
y/n> n
Please go to the following link: https://accounts.google.com/o/oauth2/auth?access_type=offline&client_id=redacted
Log in and authorize rclone for access
Enter verification code>
```

Copy the URL link.

## Authorize rclone from a browser on your local machine

Open Chrome (or other) and paste the link copied from the step above.

You’ll likely get prompted regarding site security, click advanced configuration, continue, accept the risks, etc. as needed. Sign in with your Google account then copy the code displayed.

## Finish ‘rclone config’ on the login node

On the login node, paste the code in the result field.

```bash
...
Enter verification code> <copied-code>
Configure this as a team drive?
y) Yes
n) No (default)
y/n> n
--------------------
[gog-remote]
type = drive
client_id = <my-client-id>
client_secret = <my-secret>
scope = drive
token = {"access_token":"redacted","token_type":"Bearer","refresh_token":"redacted","expiry":"2020-11-05T12:57:30.362283974-08:00"}
--------------------
y) Yes this is OK (default)
e) Edit this remote
d) Delete this remote
y/e/d> y
Current remotes:

Name                 Type
====                 ====
gog-remote           drive

e) Edit existing remote
n) New remote
d) Delete remote
r) Rename remote
c) Copy remote
s) Set configuration password
q) Quit config
e/n/d/r/c/s/q> q

```

Rclone remote configurations are saved in `~/.config/rclone/rclone.conf`

## Run rclone

Documentation on rclone commands is available: [https://rclone.org/commands/](https://rclone.org/commands/ "https://rclone.org/commands/")

List contents of your Google Drive

```bash
$ module load rclone/1.52.2
$ rclone ls gog-remote:
       -1 DDF-notes.docx
  3225657 fullsizeoutput.jpeg
  2317457 final.pdf
    25262 wire.PDF
```

Copy files

`$ rclone copy --help`

{: .note }
If you are familiar with `rsync`, rclone always works as if you had written a trailing / - meaning "copy the contents of this directory". This applies to all commands and whether you are talking about the source or destination.

Copy the contents of a folder from Google Drive to Talapas in your current working directory. In this example the folder is ‘MyFirstFolder’ and contains the file ‘perfsonar-pscheduletests.rft’

```bash
$ rclone copy gog-remote:myFirstFolder .
$ ls -l perfsonar-pscheduletests.rtf
-rw-r--r-- 1 user group 11693 Jul 22 16:01 perfsonar-pscheduletests.rtf
```

Copy the contents of all Google Drive to Talapas

`$ rclone copy gog-remote: /projects/pirg/shared`

Copy a file from Talapas to Google Drive

`$ rclone copy ./hello.txt gog-remote:myFirstFolder`

{: .note }
If you use the rclone sync command always run with --dry-run flag first! This command has the potential to delete data.

## Tokens and expirations

When using rclone with your own Google client ID access tokens are valid for 1 hour. But, re-authentication is immediate and requires no input of entering passwords again.
