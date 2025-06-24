resource "proxmox_vm_qemu" "cloudinit-example" {
  vmid             = 403
  name             = "dockerhost05"
  target_node      = "proxmox4"
  agent            = 1
  cores            = 2
  memory           = 2048
  boot             = "order=scsi0"        # has to be the same as the OS disk of the template
  clone            = "debian12-cloudinit" # The name of the template
  scsihw           = "virtio-scsi-single"
  vm_state         = "running"
  automatic_reboot = true

  # Cloud-Init configuration
  # cicustom   = "vendor=local:snippets/vendor.yaml" # /var/lib/vz/snippets/qemu-guest-agent.yml   /mnt/pve/cephfs/snippets/vendor.yml
  cicustom   = "vendor=/mnt/pve/cephfs/snippets/vendor.yml"
  ciupgrade  = true
  nameserver = "1.1.1.1 8.8.8.8"
  ipconfig0  = "ip=192.168.50.43/24,gw=192.168.50.10,ip6=dhcp"
  agent_timeout = 60  # Wait longer than the default 60 seconds
  skip_ipv6  = true
  ciuser     = "ciuser"
  cipassword = "Enter123!"
  sshkeys = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM6OM3GH4Y5+4y1B229qxKEN9rIuwuPBosJp+QF8DmVt dj_pr@zorab-surface"
    # "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBzYFhKI//Bn92MEEFUmRHPIPOrpa0fIHJPN2WQj1pCj dj_protocol@hotmail.com"  ANSIBLE
  # "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBvNK85gSfioToNJax7D55zoqO/bF0B66aGJyjfbBPX7 dev server 01"
  # Most cloud-init images require a serial device for their display
  serial {
    id = 0
  }

  disks {
    scsi {
      scsi0 {
        # We have to specify the disk from our template, else Terraform will think it's not supposed to be there
        disk {
          storage = "local-lvm"
          # The size of the disk should be at least as big as the disk in the template. If it's smaller, the disk will be recreated
          size = "16G"
        }
      }
    }
    ide {
      # Some images require a cloud-init disk on the IDE controller, others on the SCSI or SATA controller
      ide1 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
  }

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }
}
