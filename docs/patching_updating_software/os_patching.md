# Summary

OS patching and sowftare updates for various software products.

## LXC

Using [tteck][def] script to update LXC's.

### Steps

1. SSH onto proxmox node
2. Run script

`bash -c "$(wget -qLO - https://github.com/tteck/Proxmox/raw/main/misc/update-lxcs.sh)"`

[def]: https://tteck.github.io/Proxmox/#proxmox-ve-lxc-updater