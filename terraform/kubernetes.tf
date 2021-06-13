resource "digitalocean_kubernetes_cluster" "integration_cluster" {
  name = "${var.cluster_name}-${var.environment}"
  region = var.do_region
  version = "1.19.11-do.0"
  vpc_uuid = digitalocean_vpc.vpc.id

  node_pool {
      name = "${integration_cluster.name}-pool"
      size = "s-2vcpu-2gb"
      tags = var.pod_tags
      labels = var.pods_labels
      auto_scale = true
      min_nodes = 1
      max_nodes = 3
  }
}
