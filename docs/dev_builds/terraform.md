# Summary

Terraform installation and prereuistates

## Proxmox

root@proxmox2:/var/lib/vz/snippets# cat vendor.yaml 

```yaml
#cloud-config
runcmd:
    - apt update
    - apt install -y qemu-guest-agent
    - systemctl start qemu-guest-agent
    - reboot
# Taken from https://forum.proxmox.com/threads/combining-custom-cloud-init-with-auto-generated.59008/page-3#post-428772
```

## Cloud init template



```
curl --location 'https://proxmox2.zorab.im/api2/json/nodes/proxmox2/qemu/300/agent/network-get-interfaces' \
--header 'Authorization: PVEAPIToken=terraform@pam!terraform=d6655952-cd5e-4596-8e59-49a63beae357' \
| jq -r '.data.result[] | select(.name == "eth0") | .["ip-addresses"][] | select(.["ip-address-type"] == "ipv4") | .["ip-address"]'
```

### References

https://registry.terraform.io/providers/Telmate/proxmox/latest/docs/guides/cloud-init%2520getting%2520started
https://registry.terraform.io/providers/Telmate/proxmox/latest/docs#creating-the-connection-via-username-and-api-token 