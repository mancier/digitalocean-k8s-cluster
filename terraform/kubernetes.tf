resource "digitalocean_kubernetes_cluster" "integration_cluster" {
  name = "${var.cluster_name}-${var.environment}"
  region = var.do_region
  version = var.k8s_version
  vpc_uuid = digitalocean_vpc.vpc.id

  node_pool {
      name = "${var.cluster_name}-master"
      size = "s-2vcpu-4gb"
      node_count = 1
      auto_scale = false
      tags = var.tags
  }
  
  depends_on = [
    digitalocean_vpc.vpc
  ]
  tags = var.tags
}

resource "digitalocean_kubernetes_node_pool" "node_pool" {
  cluster_id = digitalocean_kubernetes_cluster.integration_cluster.id

  name = "${var.cluster_name}-pool"
  size = "s-2vcpu-4gb"
  tags = var.pod_tags
  labels = var.pods_labels
  auto_scale = true
  min_nodes  = 1
  max_nodes  = 5

  depends_on = [
    digitalocean_kubernetes_cluster.integration_cluster
  ]
}

resource "kubernetes_namespace" "istio_system" {
  metadata {
    name = "istio-system"
  }
}
