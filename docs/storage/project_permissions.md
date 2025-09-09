---
layout: default
title: Project Permissions
nav_order: 2
parent: Storage
---

# Manging Project Permissions

On Unix systems, permissions are fairly basic. Each filesystem item has an Owner and Group, and an associated permission for that item. [Here's a link to file permission basics if you'd like to learn more.](https://www.tutorialspoint.com/unix/unix-file-permission.htm)

All projects on Talapas are configured to secure all files with the Group permission set to `rwx`, which should allow any users in your PIRG group, `is.racs.pirg.<myPIRG>` the ability to read, write, and execute files. While we encourage collaboration within projects, sometimes you may need to have more fine-grained control over who can read/modify files.

There are two primary methods of permission control on Talapas: PIRG Groups and ACLs

## PIRG Groups

RACS has the ability to create a number of subgroups for your PIRG. For example, if I wanted to have a `students` directory in my project where students would have read/write, but they shouldn’t have access to the `staff` directory, I would request two new subgroups from RACS:

`is.racs.pirg.<myPIRG>.students` and `is.racs.pirg.<myPIRG>.staff`

Then, I would make the directories and secure them using the groups:

```bash
cd /projects/<myPIRG>

mkdir students
chgrp is.racs.pirg.<myPIRG>.students students
chmod g+s students #all new files should be created with the group permission of this directory
chmod o-rwx students

mkdir staff
chgrp is.racs.pirg.<myPIRG>.staff staff
chmod g+s staff
chmod o-rwx staff
```

Now, the students should have access to the `students` directory, but **not** the `staff` directory. In this example, you’d want to make sure to include the staff members in the `students` group, so the staff would be able to read/write the files in the `students` directory.

## Posix ACLs

The other method for controlling access is using Posix ACLs. On our old cluster, T1, we used Posix ACLs within `/projects/<myPIRG>` directory to grant users individual and differing permissions than those of the group. On T2, **we no longer _support_ the use of ACLs**.

You’re welcome to do your own research and apply whatever ACLs you’d like, but we are no longer providing guidance on setting them up, or support on how to configure them correctly.

{: .warning }
In the event of catastrophic failure, we will **not** restore the ACLs if files need to be recovered.
