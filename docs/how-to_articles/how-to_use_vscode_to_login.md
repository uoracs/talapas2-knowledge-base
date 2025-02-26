---
layout: default
title: How-To Use VSCode to Login to Talapas
parent: How-To Articles
nav_order: 1.5
---

# How-To Use VSCode to Login to Talapas

Visual Studio Code is a popular modern text editor that has SSH capabilities built-in. This allows you to edit files using the file tree and terminal built into VSCode from your workstation rather than connecting with your terminal to Talapas.

Let’s learn how to connect to Talapas using the `Remote-SSH` component of VSCode!

## Steps

1. Open VSCode !
2. Press `cmd+shift+p` for mac, or `ctrl+shift+p` for Windows, this is your “Command Palette”. Type `Remote-SSH`, and select `Remote-SSH: Connect to Host...`

    ![VSCode Step 1](../../../assets/images/vscode_1.png)

3. If you’ve connected before, your list will already have Talapas listed. For example, I have two hosts already configured. You should click `Add New SSH Host...`

    ![VSCode Step 2](../../../assets/images/vscode_2.png)

4. In the following box, write the SSH connection command, replacing `myuser` with your DuckID:

    ![VSCode Step 2](../../../assets/images/vscode_3.png)

5. For the SSH configuration file, you can use the default location that’s stored in your home directory, or you can specify a custom file if you’d like. Once you’ve set this, you should receive a notification that the host was added.

    ![VSCode Step 4](../../../assets/images/vscode_4.png)

6. Now that you have your host added, use the Command Palette to type `Remote-SSH` again, and click the same `Remote-SSH: Connect to Host...`, then select your new `login.talapas.uoregon.edu` host.

    ![VSCode Step 5](../../../assets/images/vscode_5.png)

7. A new VSCode window will open and the text box at the top will be asking for your password. Once you’ve entered that, it will ask you for your DUO login for 2-factor authentication. The trick here is to type the number `1` and hit enter, and it will use your first two-factor method configured on your DuckID account. Accept the DUO request and your VSCode window should connect.
8. In your file tree, you can click the `Open Folder` button and simply press the `Enter` key (or click the OK button), and your file tree should show all the files in your home directory. If it asks you if you want to trust the authors of the files, go ahead and click the accept button.
