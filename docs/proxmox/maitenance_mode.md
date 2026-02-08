# Summary

Reboot procedures for a proxmox HA node.

## Node maintenance

Enable proxmox maitenance mode
`ha-manager crm-command node-maintenance enable proxmox3`

Enbled CEPH maitenance mode

stop and wait for scrub and deep-scrub operations

```
ceph osd set noscrub
ceph osd set nodeep-scrub
ceph status
```

Set cluster in maintenance mode with :
`ceph osd set noout`

### Peform maitenance

Do your changes
ie: `apt update && apt upgrade`
Reboot etc

### Bring back online

```sh
ha-manager crm-command node-maintenance disable proxmox2
ceph osd unset noscrub
ceph osd unset nodeep-scrub
ceph osd unset noout
```

```sh
ha-manager status
ceph status
```