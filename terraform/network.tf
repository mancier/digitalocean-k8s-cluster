resource "digitalocean_tag" "tag" {
  for_each = toset(var.tags)
  name = each.value
}
resource "digitalocean_vpc" "vpc" {
  name = "${var.cluster_name}-${var.environment}-vpc"
  region = var.do_region
  ip_range = "10.42.0.0/16"
}

resource "digitalocean_firewall" "fw" {
  name  = "${var.cluster_name}-${var.environment}-fw"
  tags = var.tags
  inbound_rule {
    protocol = "tcp"
    port_range = "80"
    source_addresses = [ "0.0.0.0/0", "::/0" ]
  }

  inbound_rule {
    protocol = "tcp"
    port_range = "443"
    source_addresses = [ "0.0.0.0/0", "::/0" ]
  }

  inbound_rule {
    protocol = "tcp"
    port_range = "9100" # Prometheuus
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
}

/* resource "digitalocean_loadbalancer" "lb" {
  name = "${var.cluster_name}-${var.environment}-lb"
  vpc_uuid = digitalocean_vpc.vpc.id
  region = var.do_region
  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 80
    target_protocol = "http"
  }

  healthcheck {
    port     = 22
    protocol = "tcp"
  }
} */

/* output "loadbalancer_name" {
  value = digitalocean_loadbalancer.lb.name
} */