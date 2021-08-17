resource "cloudflare_record" "integration" {
    zone_id = var.
    name = "dns-integration"
    type = "A"
    value = digitalocean_kubernetes_cluster.integration_cluster.lb_ingress_ip
}