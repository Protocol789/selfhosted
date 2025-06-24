# Summary 

New proxmox server first steps.

# Steps

1. Install proxmox
2. Set DNS for server on pihole (eg: `proxmox5.server 192.168.50.20`)

## Proxmox Shell console

1. Run [Proxmox community post install script ][def]
    1. `bash -c "$(wget -qLO - https://github.com/community-scripts/ProxmoxVE/raw/main/misc/post-pve-install.sh)"`
    2. Note: Update proxmox takes some time!
2. Add ssh public keys to `authorized_keys`
    1. Test SSH

## Tools

1. Add to .ssh config `C:\Users\$USERPROFILE\.ssh\config` eg:
    ```
    Host proxmox5.server
      Hostname proxmox5.server
      User root
    ```
2. Add to ansible inventory. eg:
    ```
    proxmox5:
      ansible_host: proxmox5.server
    ```
3. Add API Users via [terraform](API_USER_terraform.md) and [monitoring](API_USER.md)
4. Add to [homepage](https://homepage.zorab.im/#servers) via the `services.yaml` file
5. Add to Traefik reverse proxy
6. Add to beszel
3. Add to Get Grist
    1. https://docs.getgrist.com/uPudgVrqr5ce/Servers

    
       

#### SSH Public Keys

- Laptop
    `ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM6OM3GH4Y5+4y1B229qxKEN9rIuwuPBosJp+QF8DmVt dj_pr@zorab-surface`
- Ansible 
    `ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCVl0v+55wCOmeezUJhZdufbPBBr5sp9+V6uGWye3qMtvSlQuEMJvzuFXzvhVDgDbr9wyv7pHgz+3SdoloeVf9Ob2iP90usGeIjUiM0c4WcOSnhyPdJLqn6QhjaqHbFEEH3rXEjrIJXnSxw3+SG9mFXcWyWE9XW5mcVFnC7Cy9VfdVLnwu4lCJEQK+tduvEwwOg8cxKLLcqFV2v3Z2HaHz9g//eYC6HJcjOcoZxG8QXj6bE5v10Sl78uhb05POMqz0grsAlEaN4jgRkrqUpY65Ro5a9m5Ff9WqsyO9G9/LAmMjs/vzrw24fGN13EEWCnf6zYfYEXsWNmeXoMyeAUmgk+8/kygtuf88xZzqie3ps3lrPHjo5iIcLNZKA1Jnb8MveK5ZG6zb5yDM2S4PifkBvgI/DlJYQCmVh0WPEvSJktAQY/QHy6DMI//wQXBOQ51CmwtuDDvy2jYQ5fPDXgxI3F5a13bXjKrGqrhXKccA/N2idZ87XFH2wAkTDtcFYcUc= daniel@ansible`

<!-- defintions -->
[def]: https://community-scripts.github.io/ProxmoxVE/scripts?id=post-pve-install
