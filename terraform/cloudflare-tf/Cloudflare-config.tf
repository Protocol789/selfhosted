# Creates the CNAME record that routes http_app.${var.cloudflare_zone} to the tunnel.
resource "cloudflare_record" "http_app" {
  zone_id = var.cloudflare_zone_id
  name    = "http_app"
  content   = "${cloudflare_zero_trust_tunnel_cloudflared.auto_tunnel.cname}"
  type    = "CNAME"
  proxied = true
}

# Creates an Access application to control who can connect.
resource "cloudflare_zero_trust_access_application" "http_app" {
  zone_id          = var.cloudflare_zone_id
  name             = "Access application for http_app.${var.cloudflare_zone}"
  domain           = "http_app.${var.cloudflare_zone}"
  session_duration = "1h"
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