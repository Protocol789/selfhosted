# Quick Reference

## Daily Commands

### Create or update a specific VM
```bash
terraform apply -target=proxmox_vm_qemu.dockerhost06
```

### Destroy a specific VM
```bash
terraform destroy -target=proxmox_vm_qemu.dockerhost06
```

### Apply all changes
```bash
terraform apply
```

### Check what would change
```bash
terraform plan
```

## File Structure

```
proxmox-terraform/
├── vms.tf                           # All VM definitions (edit this to add/modify VMs)
├── providers.tf                     # Proxmox provider config
├── variables.tf                     # Variable definitions
├── credentials.auto.tfvars          # Your credentials (DO NOT COMMIT)
├── credentials.auto.tfvars.example  # Template for credentials
├── README.md                        # Full documentation
└── old_files/                       # Archived old structure
```

## Adding a New VM

1. Open `vms.tf`
2. Copy a VM resource block (from dockerhost06/07/08)
3. Change these values:
   - Resource name: `proxmox_vm_qemu.YOUR_VM_NAME`
   - `vmid = 414` (must be unique)
   - `name = "your-vm-name"`
   - `ipconfig0 = "ip=192.168.50.XX/24,..."`
4. Save and run: `terraform apply -target=proxmox_vm_qemu.YOUR_VM_NAME`

## VM Details

All VMs share these defaults:
- **Template**: debian12-cloudinit
- **Cores**: 2
- **Memory**: 2048 MB
- **Disk**: 16GB on local-lvm
- **Network**: vmbr0
- **User**: ciuser
- **SSH Key**: Already configured in vms.tf
