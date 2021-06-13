terraform {
  backend "local" {
    workspace_dir = "./terraform"
  }
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 2.0"
    }

    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

provider "cloudflare" {
  email   = var.cloudflare_email
  api_key = var.cloudflare_api_key
}

provider "kubernetes" {
  host = data.digitalocean_kubernetes_cluster.integration_cluster.endpoint
  token = data.digitalocean_kubernetes_cluster.integration_cluster.kube_config[0].token
  cluster_ca_certificate = base64decode(data.digitalocean_kubernetes_cluster.integration_cluster.kube_config[0].cluster_ca_certificate)
}