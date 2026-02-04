variable "name" {
  type = string
}

variable "node_name" {
  type = string
}

variable "ssh_key" {
  type = string
}

variable "password" {
  type = string
  sensitive = true
}

variable "ipv4" {
  type    = string
  default = "dhcp"
}

variable "cloud_image_id" {
  type = string
}

variable "disk_datastore" {
  type    = string
  default = "local-lvm"
}

variable "file_datastore" {
  type    = string
  default = "local"
}

variable "bridge" {
  type    = string
  default = "vmbr1"
}

variable "memory_dedicated" {
  type    = number
  default = 2048
}

variable "memory_floating" {
  type    = number
  default = 2048
}

variable "disk_size" {
  type    = number
  default = 16
}

variable "iothread" {
  type    = bool
  default = true
}

variable "discard" {
  type    = string
  default = "on"
}

variable "network_model" {
  type    = string
  default = "virtio"
}
