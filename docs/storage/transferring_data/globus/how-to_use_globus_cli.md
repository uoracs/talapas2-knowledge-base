---
layout: default
title: How-To Use Globus CLI on Talapas
nav_order: 7
parent: Globus
grand_parent: Transferring Data
ancestor: Storage
---

# How-To Use Globus CLI on Talapas

Globus CLI is installed on Talapas and can be used as an alternative to the [webapp](https://app.globus.org), and to programmatically initiate file transfers. This wiki how-to article walks through how to use Globus CLI on a Talapas login node. It assume you already have source and destination shares setup.

In this example I’ll use a Globus share that I have created on the ‘Talapas’ endpoint that is mapped to a subdirectory within my home directory on Talapas and the ‘UO - Information Services’ endpoint where I have requested storage and a corresponding Globus share.

## Instructions

On a login node, load python3 and globus:

`module load globus` + `module load python3`

Login to Globus:

```bash
[marka@login1 ~]$ globus login
Please authenticate with Globus here:
------------------------------------
https://auth.globus.org/v2/oauth2/authorize?client_id=b6d480cb-fb69-486b-84e5-c46d22554d6b&redirect_uri=https%3A%2F%2Fauth.globus.org%2Fv2%2Fweb%2Fauth-code&scope=openid+profile+email+urn%3Aglobus%3Aauth%3Ascope%3Aauth.globus.org%3Aview_identity_set+urn%3Aglobus%3Aauth%3Ascope%3Atransfer.api.globus.org%3Aall&state=_default&response_type=code&access_type=offline&prompt=login
------------------------------------

Enter the resulting Authorization Code here: <xxxxxxxxxxxxxxxxxx>

You have successfully logged in to the Globus CLI!

You can check your primary identity with
  globus whoami

For information on which of your identities are in session use
  globus session show

Logout of the Globus CLI with
  globus logout
```

Discover the source endpoint share ID. This is my globus share on Talapas:

```bash
[marka@login1 ~]$ globus endpoint search 'Talapas'
ID                                   | Owner             | Display Name
------------------------------------ | ----------------- | ----------------
...
adc038d8-0fcb-11ea-8a67-0e35e66293c2 | marka@uoregon.edu | Talapas_marka
...
```

Discover the destination endpoint ID. This is the UO - Information Services endpoint top level share. _(This endpoint has since been deprecated but the process is the same for other endpoints)_

```bash
[marka@login1 marka_globusEP]$ globus endpoint search 'UO - Information Services'
ID                                   | Owner                | Display Name
------------------------------------ | -------------------- | -------------------------
8fcb5320-1b71-11e9-9f9f-0a06afd4a22e | uoregon@globusid.org | UO - Information Services
```

Create variables for each endpoint ID for ease of use and list the contents of each. ep1 is Talapas and ep2 is UO - Information Services

```bash
[marka@login1 ~]$ ep1=adc038d8-0fcb-11ea-8a67-0e35e66293c2
[marka@login1 ~]$ ep2=8fcb5320-1b71-11e9-9f9f-0a06afd4a22e
[marka@login1 ~]$ globus ls $ep1
mk_script_for_Talapas.R
[marka@login1 ~]$ globus ls $ep2
testu/
testf
```

The same contents viewed in the Globus web app:

![Globus Contents Web](../../../../../assets/images/globus_contents_webapp.png)

Initiate a single file transfer from the Globus CLI:

```bash
[marka@login1 ~]$ globus transfer $ep1:/mk_script_for_Talapas.R $ep2:/globus/marka/mk_script_for_Talapas.R
Message: The transfer has been accepted and a task has been created and queued for execution
Task ID: b3ad3038-109e-11ea-bea0-02fcc9cdd752
```

{: .note }
Note: The UO - Information Services endpoint ID, stored in "ep2", refers to “/”. You have to specify the full path to your individual share on the endpoint, e.g. "ep2:/globus/marka”. At initial login through the web app to the UO - Information Services endpoint, your Path is displayed as “/~/”. If you wish, you can use the up arrow to navigate up the directory hierarchy then back down into your individual share to display the actual Path.

New contents of the destination endpoint showing the new file, mk_script_for_Talapas.R.

```bash
[marka@login1 ~]$ globus ls $ep2
testu/
mk_script_for_Talapas.R
testf
```

Contents of the Globus web app file-transfer view showing the full path to my share on the UO - Information Services endpoint as well as new file ‘mk_script_for_Talapas.R’ successfully transferred.

![Globus Successful Transfer Web](../../../../../assets/images/globus_web_transfer.png)

Use `globus --help` for a basic help list. More examples can be found [here](https://docs.globus.org/cli/examples/).

As well as the full [CLI command reference](https://docs.globus.org/cli/reference/).

Look into the [globus transfer reference page](https://docs.globus.org/cli/reference/transfer/) for information on the command line options available.

In particular `--sync-level` and `--recursive`.
