# Gets the tunnel ID for the tunnel to proxy through
data "cloudflare_zero_trust_tunnel_cloudflared" "http_tunnel" {
  account_id = var.cloudflare_account_id
  name       = "Frontend Server"
}

# Creates the CNAME record that routes http_app.${var.cloudflare_zone} to the tunnel.
resource "cloudflare_record" "http_app" {
  zone_id = var.cloudflare_zone_id
  name    = "http_app"
  content = "${data.cloudflare_zero_trust_tunnel_cloudflared.http_tunnel.id}.cfargotunnel.com"
  type    = "CNAME"
  proxied = true

}

# Creates an Access application to control who can connect.
resource "cloudflare_zero_trust_access_application" "http_app" {
  zone_id          = var.cloudflare_zone_id
  name             = "Access application for http_app.${var.cloudflare_zone}"
  domain           = "http_app.${var.cloudflare_zone}"
  type             = "self_hosted"
  session_duration = "24h"
}

# Creates an Access policy for the application.
resource "cloudflare_zero_trust_access_policy" "http_policy" {
  application_id = cloudflare_zero_trust_access_application.http_app.id
  zone_id        = var.cloudflare_zone_id
  name           = "Example policy for http_app.${var.cloudflare_zone}"
  precedence     = "1"
  decision       = "allow"
  include {
    email = [var.cloudflare_email]
  }
}



resource "cloudflare_zero_trust_tunnel_cloudflared_config" "example" {
  account_id = var.cloudflare_account_id
  tunnel_id  = data.cloudflare_zero_trust_tunnel_cloudflared.http_tunnel.id

  config {
    warp_routing {
      enabled = true
    }
    ingress_rule {
      service  = "https://microbin.zorab.im"
      hostname = "microbin.zorab.im"
      origin_request {
        
      }

    }
  }
}

# import {
#   id = "52abbc52-77c4-4b59-8f7e-7ec09b646b85"
#   to = "cloudflare_zero_trust_tunnel_cloudflared_config"
# }