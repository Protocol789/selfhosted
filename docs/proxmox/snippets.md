# Summary

How to get snippets for vendor.yml to show up in proxmox

## Steps 

`pvesm set local --content images,rootdir,vztmpl,backup,iso,snippets`


## Create file

```sh
nano /var/lib/vz/snippets/vendor.yaml
```


```
#cloud-config
runcmd:
    - apt update
    - apt install -y qemu-guest-agent
    - systemctl start qemu-guest-agent
    - reboot
# Taken from https://forum.proxmox.com/threads/combining-custom-cloud-init-with-auto-generated.59008/page-3#post-428772
```