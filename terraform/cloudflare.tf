/* data "cloudflare_zones" "cf_zones" {
  filter {
    name = "ikatec.cloud"
  }
}

resource "cloudflare_record" "integration" {
    zone_id = data.cloudflare_zones.cf_zones.id
    name = "dns-integration"
    type = "A"
    value = helm_release.istio_ingress.
} */