# Gets the tunnel ID for the tunnel to proxy through
data "cloudflare_zero_trust_tunnel_cloudflared" "http_tunnel" {
  account_id = var.cloudflare_account_id
  name       = var.cloudflare_tunnelname
}

# Creates the CNAME record that routes http_app.${var.cloudflare_zone} to the tunnel.
resource "cloudflare_record" "http_app" {
  zone_id = var.cloudflare_zone_id
  name    = "${var.cloudflare_app_name}.${var.cloudflare_zone}"
  content = "${data.cloudflare_zero_trust_tunnel_cloudflared.http_tunnel.id}.cfargotunnel.com"
  type    = "CNAME"
  proxied = true

}

# Creates an Access application to control who can connect.
resource "cloudflare_zero_trust_access_application" "http_app" {
  zone_id          = var.cloudflare_zone_id
  name             = "Access application for ${var.cloudflare_app_name}.${var.cloudflare_zone}"
  domain           = "${var.cloudflare_app_name}.${var.cloudflare_zone}"
  type             = "self_hosted"
  session_duration = "24h"
  allowed_idps     = ["a1bc7267-5818-4c39-9c9d-fc1c7e2615d1"] # Google
}

# Creates an Access policy for the application.
resource "cloudflare_zero_trust_access_policy" "http_policy" {
  application_id = cloudflare_zero_trust_access_application.http_app.id
  zone_id        = var.cloudflare_zone_id
  name           = "Policy for ${var.cloudflare_app_name}.${var.cloudflare_zone}"
  precedence     = "1"
  decision       = "allow"
  require {
    group = ["58fca8b4-a30d-489c-9265-2ffd34093e27"] # Zorab users
  }
  include {
    group = ["2c5bda25-ea7b-488b-b009-987993bdc5dd"] # Zorab countries
  }

}



# resource "cloudflare_zero_trust_tunnel_cloudflared_config" "example" {
#   account_id = var.cloudflare_account_id
#   tunnel_id  = data.cloudflare_zero_trust_tunnel_cloudflared.http_tunnel.id

#   config {
#     warp_routing {
#       enabled = true
#     }
#     ingress_rule {
#       service  = "https://microbin.zorab.im"
#       hostname = "microbin.zorab.im"
#       origin_request {

#       }

#     }
#   }
# }

# import {
#   id = "52abbc52-77c4-4b59-8f7e-7ec09b646b85"
#   to = "cloudflare_zero_trust_tunnel_cloudflared_config"
# }
