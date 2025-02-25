# Proxmox 2
proxmox_api_url             = "https://proxmox2.zorab.im/api2/json"         # Your proxmox server
proxmox_api_token_id        = "terraform@pam!terraform"                     # Replace with your API token ID
proxmox_api_token_secret    = "d6655952-cd5e-4596-8e59-49a63beae357"        # Replace with your API token secret 
proxmox_tls_insecure        = false                                         # Set to false if using a valid SSL certificate
proxmox_template_name       = "debian12-cloudinit"                          # The template you will be cloning

# Proxmox 3
proxmox_api_url             = "https://proxmox3.zorab.im/api2/json"         # Your proxmox server
proxmox_api_token_id        = "terraform-user@pve!terraform-token"                     # Replace with your API token ID
proxmox_api_token_secret    = "7a4f5fa0-52f1-41e1-9c4e-53eac9b25d59"        # Replace with your API token secret 
proxmox_tls_insecure        = false                                         # Set to false if using a valid SSL certificate
proxmox_template_name       = "debian12-cloudinit"                          # The template you will be cloning