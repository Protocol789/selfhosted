terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = ">= 4.40.0"
    }
  }
}

# Providers
provider "cloudflare" {
  api_token    = var.cloudflare_token
}