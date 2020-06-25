locals {
  mx_providers = {
    none   = {}
    custom = var.custom_mx_servers
    google = {
      "aspmx.l.google.com"      = 10
      "alt1.aspmx.l.google.com" = 20
      "alt2.aspmx.l.google.com" = 20
      "aspmx2.googlemail.com"   = 30
      "aspmx3.googlemail.com"   = 30
      "aspmx4.googlemail.com"   = 30
      "aspmx5.googlemail.com"   = 30
    }
    improvmx = {
      "mx1.improvmx.com" = 10
      "mx2.improvmx.com" = 20
    }
  }
  mx_servers = local.mx_providers[var.mx_provider]
}
resource "cloudflare_zone" "zone" {
  zone = var.zone
}

resource "cloudflare_record" "www" {
  zone_id = cloudflare_zone.zone.id
  name    = "www"
  type    = "CNAME"
  ttl     = var.ttl
  proxied = var.proxied
  value   = cloudflare_zone.zone.zone
}

resource "cloudflare_record" "mx" {
  for_each = local.mx_servers
  zone_id  = cloudflare_zone.zone.id
  name     = cloudflare_zone.zone.zone
  type     = "MX"
  value    = each.key
  priority = each.value
}
