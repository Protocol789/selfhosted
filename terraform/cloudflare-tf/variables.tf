# Cloudflare variables
variable "cloudflare_zone" {
  description = "Domain used to expose the GCP VM instance to the Internet"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "Zone ID for your domain"
  type        = string
}

variable "cloudflare_account_id" {
  description = "Account ID for your Cloudflare account"
  type        = string
  sensitive   = true
}

variable "cloudflare_email" {
  description = "Email address for your Cloudflare account"
  type        = string
  sensitive   = true
}

variable "cloudflare_token" {
  description = "Cloudflare API token created at https://dash.cloudflare.com/profile/api-tokens"
  type        = string
  sensitive   = true
}

variable "cloudflare_app_name" {
  description = "The application cname you want to setup"
  type        = string
  #default     = ""
}

variable "cloudflare_tunnelname" {
  description = "The cloudflare tunnel name reference to add the appliocation to"
  type        = string
}

variable "cloudflare_tunnelid" {
  description = "The cloudflare tunnel ID reference to add the application to"
  type        = string
}
