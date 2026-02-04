resource "proxmox_virtual_environment_file" "meta_data_cloud_config" {
  content_type = "snippets"
  datastore_id = var.file_datastore
  node_name    = var.node_name

  source_raw {
    data = <<-EOF
    #cloud-config
    local-hostname: ${var.name}
    EOF

    file_name = "${var.name}-meta-data-cloud-config.yaml"
  }
}

resource "proxmox_virtual_environment_file" "user_data_cloud_config" {
  content_type = "snippets"
  datastore_id = var.file_datastore
  node_name    = var.node_name

  source_raw {
    data = <<-EOF
    #cloud-config
    users:
      - name: ciuser
        ssh_authorized_keys:
          - ${var.ssh_key}
        lock_passwd: false
        passwd: ${var.password}
    EOF

    file_name = "${var.name}-user-data-cloud-config.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "vm" {
  name      = var.name
  node_name = var.node_name
  tags      = ["terraform"]

  stop_on_destroy = true

  agent {
    enabled = false
  }

  memory {
    dedicated = var.memory_dedicated
    floating  = var.memory_floating
  }

  initialization {
    user_account {
      username = "ciuser"
      password = var.password
      keys     = [var.ssh_key]
    }

    ip_config {
      ipv4 {
        address = var.ipv4
      }
      ipv6 {
        address = "auto"
      }
    }

    vendor_data_file_id = proxmox_virtual_environment_file.user_data_cloud_config.id
    meta_data_file_id   = proxmox_virtual_environment_file.meta_data_cloud_config.id
  }

  serial_device {}

  network_device {
    bridge = var.bridge
    model  = var.network_model
  }

  disk {
    datastore_id = var.disk_datastore
    import_from  = var.cloud_image_id
    interface    = "virtio0"
    iothread     = var.iothread
    discard      = var.discard
    size         = var.disk_size
  }
}
