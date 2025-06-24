terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.70.1"
    }
  }
}

# Providers

provider "proxmox" {
  endpoint      = var.proxmox_api_url
  api_token     = var.proxmox_api_token
  # username      = var.proxmox_api_token_id
  # password      = var.proxmox_api_token_secret
  insecure      = var.proxmox_tls_insecure
  ssh {
    agent = true
    # TODO: uncomment and configure if using api_token instead of password
    # username = "root"
  }
}

