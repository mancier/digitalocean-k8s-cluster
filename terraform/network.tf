resource "digitalocean_vpc" "vpc" {
  name = "${var.name}-${var.environment}-vpc"
  region = var.do_region
  ip_range = "10.42.0.0/16"
}