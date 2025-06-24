# Proxmox variables
variable "proxmox_api_url" {
  description = "The URL of the Proxmox API"
  type        = string
  # default     = "https://your-proxmox-server:8006/api2/json" # Replace with your Proxmox server URL
}

variable "proxmox_api_token_id" {
  description = "The API token ID for Proxmox"
  type        = string
  # default     = "your-token-id" # Replace with your API token ID
}

variable "proxmox_api_token_secret" {
  description = "The API token secret for Proxmox"
  type        = string
  # default     = "your-token-secret" # Replace with your API token secret
}

variable "proxmox_tls_insecure" {
  description = "Whether to ignore TLS certificate errors"
  type        = bool
  # default     = true # Set to false if using a valid SSL certificate
}

variable "proxmox_template_name"{
  description = "The template which is used as a base"
  type        = string
}

variable "proxmox_api_token"{
  description = "API Token in the form of username@realm!for-terraform-provider=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx"
  type        = string
}