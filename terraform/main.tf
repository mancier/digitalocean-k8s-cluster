terraform {
  backend "local" {
    workspace_dir = "."
    path = "states/terraform.tfstate"
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
