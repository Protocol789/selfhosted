# All VM configurations in one place
# To create/update a specific VM: terraform apply -target=proxmox_vm_qemu.dockerhost06
# To destroy a specific VM: terraform destroy -target=proxmox_vm_qemu.dockerhost06
# To manage all VMs: terraform apply

resource "proxmox_vm_qemu" "dockerhost06" {
  vmid             = 411
  name             = "dockerhost06"
  target_node      = "proxmox5"
  agent            = 1
  memory           = 2048
  boot             = "order=scsi0"
  # clone            = "ubuntu-cloud-init-template"
  clone            = "debian12-cloudinit"
  scsihw           = "virtio-scsi-single"
  automatic_reboot = true
  force_create     = true
  tags             = "dockerhost,ci"
  
  # Timeout settings
  # clone_wait       = 30           # Wait time for clone to complete (minutes)
  # additional_wait  = 15           # Additional wait after VM is running (seconds)
  agent_timeout    = 300          # Timeout for QEMU agent (seconds)
  
  cicustom         = "vendor=cephfs:snippets/vendor.yml"
  ciupgrade        = "false"
  # nameserver       = "1.1.1.1 8.8.8.8"
  ipconfig0        = "ip=192.168.50.48/24,gw=192.168.50.10"
  ciuser           = "ciuser"
  cipassword       = "Enter123!"
  # sshkeys          = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM6OM3GH4Y5+4y1B229qxKEN9rIuwuPBosJp+QF8DmVt dj_pr@zorab-surface"
  vm_state         = "running"

  cpu {
    cores = 2
  }

  serial {
    id   = 0
    type = "socket"
  }

  disks {
    scsi {
      scsi0 {
        disk {
          storage = "local-lvm"
          size    = "16G"
        }
      }
    }
    ide {
      ide1 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
  }

  network {
    id     = 0
    bridge = "vmbr0"
    model  = "virtio"
  }

  # Terraform resource timeout
  timeouts {
    create = "15m"  # 15 minutes for creation
    update = "10m"  # 10 minutes for updates
    delete = "10m"  # 10 minutes for deletion
  }
}

# resource "proxmox_vm_qemu" "dockerhost07" {
#   vmid             = 412
#   name             = "dockerhost07"
#   target_node      = "proxmox5"
#   agent            = 1
# #   cores            = 2
#   memory           = 2048
#   boot             = "order=scsi0"
#   clone            = "debian12-cloudinit"
#   scsihw           = "virtio-scsi-single"
#   automatic_reboot = true

#   cicustom   = "vendor=/mnt/pve/cephfs/snippets/vendor.yml"
#   nameserver = "1.1.1.1 8.8.8.8"
#   ipconfig0  = "ip=192.168.50.44/24,gw=192.168.50.10,ip6=dhcp"
#   ciuser     = "ciuser"
#   cipassword = "Enter123!"
#   sshkeys    = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM6OM3GH4Y5+4y1B229qxKEN9rIuwuPBosJp+QF8DmVt dj_pr@zorab-surface"

#   serial {
#     id   = 0
#     type = "socket"
#   }

#   disks {
#     scsi {
#       scsi0 {
#         disk {
#           storage = "local-lvm"
#           size    = "16G"
#         }
#       }
#     }
#     ide {
#       ide1 {
#         cloudinit {
#           storage = "local-lvm"
#         }
#       }
#     }
#   }

#   network {
#     id     = 0
#     bridge = "vmbr0"
#     model  = "virtio"
#   }
# }

# resource "proxmox_vm_qemu" "dockerhost08" {
#   vmid             = 413
#   name             = "dockerhost08"
#   target_node      = "proxmox5"
#   agent            = 1
# #   cores            = 2
#   memory           = 2048
#   boot             = "order=scsi0"
#   clone            = "debian12-cloudinit"
#   scsihw           = "virtio-scsi-single"
#   automatic_reboot = true

#   cicustom   = "vendor=/mnt/pve/cephfs/snippets/vendor.yml"
#   nameserver = "1.1.1.1 8.8.8.8"
#   ipconfig0  = "ip=192.168.50.45/24,gw=192.168.50.10,ip6=dhcp"
#   ciuser     = "ciuser"
#   cipassword = "Enter123!"
#   sshkeys    = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM6OM3GH4Y5+4y1B229qxKEN9rIuwuPBosJp+QF8DmVt dj_pr@zorab-surface"

#   serial {
#     id   = 0
#     type = "socket"
#   }

#   disks {
#     scsi {
#       scsi0 {
#         disk {
#           storage = "local-lvm"
#           size    = "16G"
#         }
#       }
#     }
#     ide {
#       ide1 {
#         cloudinit {
#           storage = "local-lvm"
#         }
#       }
#     }
#   }

#   network {
#     id     = 0
#     bridge = "vmbr0"
#     model  = "virtio"
#   }
# }
