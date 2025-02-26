---
layout: default
title: Dropbox
nav_order: 2
parent: Data Movement
---

# Dropbox

Dropbox can be accessed for browsing and data transfers from Talapas login nodes using the process described below. The following steps configures an rclone remote connection to your Dropbox account.

## Create UO Dropbox account

If you do not already have a UO affiliated Dropbox account, follow [these instructions](https://service.uoregon.edu/TDClient/2030/Portal/KB/ArticleDet?ID=102716) to setup your Dropbox account.

## Setup a Dropbox app

Follow _only_ the instructions in the section “Get your own Dropbox App ID” in this [IS Knowledge Base article](https://service.uoregon.edu/TDClient/2030/Portal/KB/ArticleDet?ID=111417) to create a Dropbox app.

Rclone will use your Dropbox app id credentials to authenticate to your Dropbox account when configuring the remote connection.

Ensure your Dropbox app has the permissions below. This can be edited under the Permissions tab of your Dropbox App.

- ‘files.content.read’
- ‘files.content.write’

The example below configures an `rclone` remote location named dbx-remote. Your rclone remote name can be anything (descriptive is probably better). It will be used as a command line argument to rclone and does not need to be the same as your Dropbox app name.

Substitute app-key and app-secret for your own Dropbox app key and secret.

## Run `rclone config` on a login node

```bash
$ module load rclone/1.52.2
$ rclone config
2020/08/05 12:01:58 NOTICE: Config file "~/.config/rclone/rclone.conf" not found - using defaults
No remotes found - make a new one
n) New remote
s) Set configuration password
q) Quit config
n/s/q> n
name> dbx-remote
Type of storage to configure.
Enter a string value. Press Enter for the default ("").
Choose a number from below, or type in your own value
 1 / 1Fichier
   \ "fichier"
 2 / Alias for an existing remote
   \ "alias"
 3 / Amazon Drive
   \ "amazon cloud drive"
 4 / Amazon S3 Compliant Storage Provider (AWS, Alibaba, Ceph, Digital Ocean, Dreamhost, IBM COS, Minio, etc)
   \ "s3"
 5 / Backblaze B2
   \ "b2"
 6 / Box
   \ "box"
 7 / Cache a remote
   \ "cache"
 8 / Citrix Sharefile
   \ "sharefile"
 9 / Dropbox
   \ "dropbox"
...
Storage> 9
** See help for dropbox backend at: https://rclone.org/dropbox/ **

Dropbox App Client Id
Leave blank normally.
Enter a string value. Press Enter for the default ("").
client_id> <app-key>
Dropbox App Client Secret
Leave blank normally.
Enter a string value. Press Enter for the default ("").
client_secret> <app-secret>
Edit advanced config? (y/n)
y) Yes
n) No (default)
y/n> n
Remote config
Make sure your Redirect URL is set to "http://localhost:53682/" in your custom config.
Use auto config?
 * Say Y if not sure
 * Say N if you are working on a remote or headless machine
y) Yes (default)
n) No
y/n> n
For this to work, you will need rclone available on a machine that has
a web browser available.

For more help and alternate methods see: https://rclone.org/remote_setup/

Execute the following on the machine with the web browser (same rclone
version recommended):

	rclone authorize "dropbox" -- "<app-key>" "<app-secret>"

Then paste the result below:
result>
```

Copy the rclone authorize line.

## Run ‘rclone authorize’ on your local machine

Running this step on your local machine is required since Talapas login nodes do not run web browsers.

### Install rclone 1.52.2 on your local machine if not already installed

For example, to install on Linux or Mac run:

```bash
$ curl https://rclone.org/install.sh | sudo bash
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  4436  100  4436    0     0   5783      0 --:--:-- --:--:-- --:--:--  5776Password:

  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100    15  100    15    0     0     10      0  0:00:01  0:00:01 --:--:--    10
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 16.1M  100 16.1M    0     0  2267k      0  0:00:07  0:00:07 --:--:-- 3028k
Archive:  rclone-current-osx-amd64.zip
   creating: tmp_unzip_dir_for_rclone/rclone-v1.52.2-osx-amd64/
 extracting: tmp_unzip_dir_for_rclone/rclone-v1.52.2-osx-amd64/git-log.txt  [empty]
  inflating: tmp_unzip_dir_for_rclone/rclone-v1.52.2-osx-amd64/rclone  [binary]
  inflating: tmp_unzip_dir_for_rclone/rclone-v1.52.2-osx-amd64/rclone.1  [text]
  inflating: tmp_unzip_dir_for_rclone/rclone-v1.52.2-osx-amd64/README.html  [text]
  inflating: tmp_unzip_dir_for_rclone/rclone-v1.52.2-osx-amd64/README.txt  [text]

rclone v1.52.2 has successfully installed.
Now run "rclone config" for setup. Check https://rclone.org/docs/ for more details.

$ rclone --version
rclone v1.52.2
```

### Run rclone authorize on your local machine

On your local machine, paste the rclone authorize line you copied from the rclone config step on login node.

This will trigger your browser to open a tab requesting approval for rclone to connect to Dropbox, click ‘Allow’. Copy the code provided in the output of rclone authorize and return to the Talapas login node.

```bash
$ rclone authorize "dropbox" -- "<app-key>" "<app-secret>"
2020/08/05 12:09:50 NOTICE: Config file "~/.config/rclone/rclone.conf" not found - using defaults
Make sure your Redirect URL is set to "http://localhost:53682/" in your custom config.
If your browser doesn't open automatically go to the following link: http://127.0.0.1:53682/auth?state=redacted
Log in and authorize rclone for access
Waiting for code...
Got code
Paste the following into your remote machine --->
{"access_token":"redacted","token_type":"bearer","expiry":"2020-08-05T16:10:21.28527-07:00"}
<---End paste 
```

## Finish ‘rclone config’ on the login node

On the login node, paste the code in the result field.

```bash
...
Then paste the result below:
result> {"access_token":"redacted","token_type":"bearer","expiry":"2020-08-05T16:10:21.28527-07:00"}
--------------------
[dbx-remote]
type = dropbox
client_id = <app-key>
client_secret = <app-secret>
token = {"access_token":"redacted","token_type":"bearer","expiry":"2020-08-05T16:10:21.28527-07:00"}
--------------------
y) Yes this is OK (default)
e) Edit this remote
d) Delete this remote
y/e/d> y
Current remotes:

Name                 Type
====                 ====
dbx-remote           dropbox

e) Edit existing remote
n) New remote
d) Delete remote
r) Rename remote
c) Copy remote
s) Set configuration password
q) Quit config
e/n/d/r/c/s/q> q

```

The rclone remote configuration created is saved in `~/.config/rclone/rclone.conf`

## Run rclone

Documentation on rclone commands is available: [https://rclone.org/commands/](https://rclone.org/commands/ "https://rclone.org/commands/")

List contents of your Dropbox

```bash
$ rclone lsd dbx-remote:
          -1 2020-08-06 10:13:47        -1 myFirstFolder
$ rclone ls dbx-remote:
      240 Get Started with Dropbox Paper.url
  1102331 Get Started with Dropbox.pdf
    11693 myFirstFolder/perfsonar-pschedule tests.rtf
```

Copy files

`$ rclone copy --help`

If you are familiar with `rsync`, `rclone` always works as if you had written a trailing / - meaning "copy the contents of this directory". This applies to all commands and whether you are talking about the source or destination.

Copy the contents of a folder from Dropbox to Talapas in your current working directory. In this example the folder is `MyFirstFolder` and contains the file `perfsonar-pscheduletests.rft`

`$ rclone copy dbx-remote:myFirstFolder .` `$ ls -l perfsonar-pscheduletests.rtf`

`-rw-r--r-- 1 user group 11693 Jul 22 16:01 perfsonar-pscheduletests.rtf`

Copy the contents of all Dropbox to Talapas

`$ rclone copy dbx-remote: /projects/pirg/shared`

Copy a file from Talapas to Dropbox

`$ rclone copy ./hello.txt dbx-remote:myFirstFolder`

{: .note }
If you use the `rclone sync` command always run with --dry-run flag first! This command has the potential to delete data.

## Re-authenticate rclone

Rclone authentication to Dropbox expires after 4 hours and to continue you will need to reconnect. The process is similar to above as you’ll need to run rclone authorize on your local machine.

On the login node, note the expiration error below. Run rclone config reconnect.

```bash
$ rclone lsd dbx-remote:
2020/08/06 10:11:36 ERROR : : error listing: Post "https://api.dropboxapi.com/2/files/list_folder": couldn't fetch token - maybe it has expired? - refresh with "rclone config reconnect dbx-remote:": oauth2: token expired and refresh token is not set
2020/08/06 10:11:36 Failed to lsd with 2 errors: last error was: Post "https://api.dropboxapi.com/2/files/list_folder": couldn't fetch token - maybe it has expired? - refresh with "rclone config reconnect dbx-remote:": oauth2: token expired and refresh token is not set
$
$ rclone config reconnect dbx-remote:
Already have a token - refresh?
y) Yes (default)
n) No
y/n> y
Make sure your Redirect URL is set to "http://localhost:53682/" in your custom config.
Use auto config?
 * Say Y if not sure
 * Say N if you are working on a remote or headless machine
y) Yes (default)
n) No
y/n> n
For this to work, you will need rclone available on a machine that has
a web browser available.

For more help and alternate methods see: https://rclone.org/remote_setup/

Execute the following on the machine with the web browser (same rclone
version recommended):

	rclone authorize "dropbox" -- "<app-key>" "<app-secret>"

Then paste the result below:
result>
```

On your local machine, run rclone authorize, click ‘Allow’ in your web browser to approve the connection and copy the resulting code.

```bash
$ rclone authorize "dropbox" -- "<app-key>" "<app-secret>"
Make sure your Redirect URL is set to "http://localhost:53682/" in your custom config.
If your browser doesn't open automatically go to the following link: http://127.0.0.1:53682/auth?state=redacted
Log in and authorize rclone for access
Waiting for code...
Got code
Paste the following into your remote machine --->
{"access_token":"redacted","token_type":"bearer","expiry":"2020-08-06T14:13:44.524022-07:00"}
<---End paste
```

On the login node, paste the code and run rclone.

```bash
...
Then paste the result below:
result> {"access_token":"redacted","token_type":"bearer","expiry":"2020-08-06T14:13:44.524022-07:00"}
$
$ rclone lsd dbx-remote:
          -1 2020-08-06 10:13:47        -1 myFirstFolder
```
