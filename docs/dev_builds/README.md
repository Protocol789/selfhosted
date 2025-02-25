# Summary

This creates a dev server using terraform and ansible

## Ansible


Use the `--limit hostname` to apply only to the machine you want.

```bash
# This updates APT, proxmox qemu agent and reboots
ansible-playbook -i production.yml playbooks/update_qemuagent/qemuagent.yml
# This sets up docker 
ansible-playbook -i production.yml playbooks/docker/docker.yml
# This installs tailscale with an predefine AUTH key 
ansible-playbook -i production.yml playbooks/tailscale.yml
``` 

## Terraform 

```bash
# Initilizate terraform with congfig and depedancies
terraform init 

# plane the change
terraform plan

# Make the change
terrform apply

# Remove the change
terraform destroy 

```


## References

ansible-playbook -i inventory_file playbook.yml 
https://spacelift.io/blog/terraform-proxmox-provider
<!-- # This one seemd to work -->
https://registry.terraform.io/providers/bpg/proxmox/latest/docs/guides/clone-vm
<!-- This didn't as think it needs a cluster to work properly? -->
https://registry.terraform.io/providers/Telmate/proxmox/latest/docs#creating-the-connection-via-username-and-api-token