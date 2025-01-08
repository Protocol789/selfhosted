# Creates the CNAME record that routes http_app.${var.cloudflare_zone} to the tunnel.

# 52abbc52-77c4-4b59-8f7e-7ec09b646b85
# a2cb44dd-8d73-4761-8921-1b88838b0baa.cfargotunnel.com
# Frontend Server

data "cloudflare_zero_trust_tunnel_cloudflared" "http_tunnel" {
  account_id = var.cloudflare_account_id
  name = "Frontend Server"
}

resource "cloudflare_record" "http_app" {
  zone_id = var.cloudflare_zone_id
  name    = "http_app"
  content = "${data.cloudflare_zero_trust_tunnel_cloudflared.http_tunnel.id}.cfargotunnel.com"
  type    = "CNAME"
  proxied = true

}

# resource "cloudflare_dns_record" "http_app" {
#   zone_id = var.cloudflare_zone_id
#   name    = "http_app"
#   # value   = cloudflare_zero_trust_tunnel_cloudflared.http_tunnel.tunnel_id
#   type    = "CNAME"
#   proxied = true
#   ttl     = 3600
# }


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
