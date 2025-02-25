resource "proxmox_vm_qemu" "cloudinit-example" {
  vmid        = 300
  name        = "devserver03"
  target_node = "proxmox"
  agent       = 1
  cores       = 2
  memory      = 1024
  boot        = "order=scsi0" # has to be the same as the OS disk of the template
  clone       = "debian12-cloudinit" # The name of the template
  scsihw      = "virtio-scsi-single"
  vm_state    = "running"
  automatic_reboot = true

  # Cloud-Init configuration
  cicustom   = "vendor=local:snippets/vendor.yaml" # /var/lib/vz/snippets/qemu-guest-agent.yml
  ciupgrade  = true
  nameserver = "1.1.1.1 8.8.8.8"
  ipconfig0  = "ip=dhcp,ip6=dhcp"
  # agent_timeout = 360  # Wait longer than the default 60 seconds
  skip_ipv6  = true
  ciuser     = "ciuser"
  cipassword = "Enter123!"
  sshkeys    = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBvNK85gSfioToNJax7D55zoqO/bF0B66aGJyjfbBPX7 dev server 01"

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
          size    = "8G" 
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
