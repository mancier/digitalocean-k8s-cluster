provider "digitalocean" {
  token = var.do_token
}

provider "cloudflare" {
  email   = var.cloudflare_email
  api_key = var.cloudflare_api_key
}

provider "helm" {
  kubernetes {
    host = digitalocean_kubernetes_cluster.integration_cluster.endpoint
    token = digitalocean_kubernetes_cluster.integration_cluster.kube_config[0].token
    cluster_ca_certificate = base64decode(digitalocean_kubernetes_cluster.integration_cluster.kube_config[0].cluster_ca_certificate)
  }
}
provider "kubernetes" {
    host = digitalocean_kubernetes_cluster.integration_cluster.endpoint
    token = digitalocean_kubernetes_cluster.integration_cluster.kube_config[0].token
    cluster_ca_certificate = base64decode(digitalocean_kubernetes_cluster.integration_cluster.kube_config[0].cluster_ca_certificate)
}
