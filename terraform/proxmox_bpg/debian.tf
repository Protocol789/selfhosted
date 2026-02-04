

# # Import Debian cloud image to Proxmox node proxmox2 on CephFS datastore
# # This image can then be used by all nodes if they have access to the CephFS datastore

# resource "proxmox_virtual_environment_download_file" "debian_cloud_image_proxmox2" {
#   content_type = "import"
#   datastore_id = "cephfs"
#   node_name    = "proxmox2"
#   url          = "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2"
#   overwrite    = false
# }


# Use remote state to get image IDs
data "terraform_remote_state" "images" {
  backend = "local"
  config = {
    path = "./images/terraform.tfstate"
  }
}

module "debian_a" {
  source         = "./modules/proxmox_vm"
  name           = "test-debian-a"
  node_name      = "proxmox2"
  ssh_key        = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBzYFhKI//Bn92MEEFUmRHPIPOrpa0fIHJPN2WQj1pCj ansible"
  password       = "password123"
  ipv4           = "dhcp"
  bridge         = "vmbr1"
  cloud_image_id = data.terraform_remote_state.images.outputs.debian_image_id
}

module "debian_b" {
  source         = "./modules/proxmox_vm"
  name           = "test-debian-b"
  node_name      = "proxmox3"
  ssh_key        = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBzYFhKI//Bn92MEEFUmRHPIPOrpa0fIHJPN2WQj1pCj ansible"
  password       = "password123"
  ipv4           = "dhcp"
  bridge         = "vmbr0"
  cloud_image_id = data.terraform_remote_state.images.outputs.debian_image_id
}

module "debian_c" {
  source         = "./modules/proxmox_vm"
  name           = "test-debian-c"
  node_name      = "proxmox4"
  ssh_key        = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBzYFhKI//Bn92MEEFUmRHPIPOrpa0fIHJPN2WQj1pCj ansible"
  password       = "password123"
  ipv4           = "dhcp"
  bridge         = "vmbr0"
  cloud_image_id = data.terraform_remote_state.images.outputs.debian_image_id
}


module "debian_d" {
  source         = "./modules/proxmox_vm"
  name           = "test-debian-d"
  node_name      = "proxmox5"
  ssh_key        = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBzYFhKI//Bn92MEEFUmRHPIPOrpa0fIHJPN2WQj1pCj ansible"
  password       = "password123"
  ipv4           = "dhcp"
  bridge         = "vmbr0"
  cloud_image_id = data.terraform_remote_state.images.outputs.debian_image_id
}



# If CEPH isn't avlaiable, it'll need to be downloaded to each individual node

# resource "proxmox_virtual_environment_download_file" "debian_cloud_image_proxmox3" {
#   content_type = "import"
#   datastore_id = "local"
#   node_name    = "proxmox3"
#   url          = "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2"
#   overwrite    = false
# }

# resource "proxmox_virtual_environment_download_file" "debian_cloud_image_proxmox4" {
#   content_type = "import"
#   datastore_id = "local"
#   node_name    = "proxmox4"
#   url          = "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2"
#   overwrite    = false
# }

# resource "proxmox_virtual_environment_download_file" "debian_cloud_image_proxmox5" {
#   content_type = "import"
#   datastore_id = "local"
#   node_name    = "proxmox5"
#   url          = "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2"
#   overwrite    = false
# }
