# Summary 

Proxmox CLI: Create a User for Auditing and Attach an API Key
This guide explains how to create a user for auditing purposes in Proxmox VE using the CLI. The user will have read-only access to metric data, and an API key will be generated for programmatic access.


---

## 1. Create a New User

Use the `pveum` command to create a new user. Replace `audit-user` with the desired username and `pve` with the appropriate authentication realm (e.g., `pve` for local Proxmox authentication).

```bash
pveum user add audit-user@pve
```

## 2. Set a Password for the User

Set a password for the new user. You will be prompted to enter and confirm the password.

```bash
pveum passwd audit-user@pve
```

## 3. Assign Permissions for Auditing

Grant the user read-only access to the necessary resources. For example, to grant read-only access to all nodes and VMs, use the following command:

```bash
pveum acl modify / -user audit-user@pve -role PVEAuditor
```

The Auditor role is a built-in role in Proxmox that provides read-only access to most resources. If you need more granular control, you can create a custom role with specific permissions.

## 4. Create an API Token for the User

Generate an API token for the user. This token can be used for programmatic access to the Proxmox API.

```bash
pveum user token add audit-user@pve audit-token --privsep=0
```

- `audit-token` is the name of the token (you can choose any name).
- `--privsep=0` disables privilege separation for the token, meaning it will have the same permissions as the user.

After running this command, you will receive a token value and a secret. Make sure to securely store these as they will be required for API access.

## 5. Verify the Setup

Verify the user and token setup by listing the users and tokens:

```bash
pveum user list
pveum user token list audit-user@pve
```

## 6. Test API Access
Test the API access using the generated token. For example, use curl to retrieve metrics or other data:


```bash
TOKEN='TOKENOUPUTFROMEARLIER'
USERID='audit-user@pve!audit-token'
curl -k --location 'https://proxmox3.server:8006/api2/json/nodes' \
--header "Authorization: PVEAPIToken=$USERID=$TOKEN"
```

Replace TOKEN_VALUE and SECRET with the actual token value and secret you received earlier.

### Summary

1. Created a user audit-user@pve.
2. Assigned the Auditor role for read-only access.
3. Generated an API token for programmatic access.
4. Verified the setup and tested API access.

This setup allows the audit-user to read metric data and other information from Proxmox VE for auditing purposes.

## Reference link

* [proxmox provider][def]

[def]: https://registry.terraform.io/providers/Terraform-for-Proxmox/proxmox/latest/docs#creating-the-proxmox-user-and-role-for-terraform

