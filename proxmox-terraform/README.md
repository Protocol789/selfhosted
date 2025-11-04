# Proxmox Terraform

Simple Terraform configuration for managing Proxmox VMs.

## Files

- **vms.tf** - All VM configurations
- **providers.tf** - Proxmox provider setup
- **variables.tf** - Variable definitions
- **credentials.auto.tfvars** - Your credentials (not in git)
- **credentials.auto.tfvars.example** - Example template

## Setup

1. **Copy credentials template:**
   ```bash
   cp credentials.auto.tfvars.example credentials.auto.tfvars
   ```

2. **Edit credentials.auto.tfvars** with your Proxmox details

3. **Initialize:**
   ```bash
   terraform init
   ```

## Usage

```bash
# Create/update all VMs
terraform apply

# Create/update specific VM
terraform apply -target=proxmox_vm_qemu.dockerhost06

# Destroy specific VM
terraform destroy -target=proxmox_vm_qemu.dockerhost06

# Preview changes
terraform plan
```

## Adding a New VM

1. Open `vms.tf`
2. Copy an existing resource block
3. Update:
   - Resource name (e.g., `proxmox_vm_qemu.newvm`)
   - `vmid` (unique ID)
   - `name`
   - `ipconfig0` (IP address)
4. Run: `terraform apply -target=proxmox_vm_qemu.newvm`

## Current VMs

- **dockerhost06** (VMID 411) - 192.168.50.43
- **dockerhost07** (VMID 412) - 192.168.50.44
- **dockerhost08** (VMID 413) - 192.168.50.45