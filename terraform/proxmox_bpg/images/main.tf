resource "proxmox_virtual_environment_download_file" "debian_cloud_image_proxmox2" {
  content_type = "import"
  datastore_id = "cephfs"
  node_name    = "proxmox2"
  url          = "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2"
  overwrite    = false
}

output "debian_image_id" {
  value = proxmox_virtual_environment_download_file.debian_cloud_image_proxmox2.id
}