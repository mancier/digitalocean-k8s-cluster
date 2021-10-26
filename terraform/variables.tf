# Secrets #
## Cloudflare
variable "cloudflare_email" {
  type = string
}
variable "cloudflare_api_key" {
  type = string
}

## Digital Ocean
variable "do_token" {
  type = string
}

variable "pod_tags" {
  type = list
  default = ["integration", "production"]
}

variable "pods_labels" {
  type = map
  default = {
    environment = "production",
    project = "integrations"
  }
}
variable "do_region" {
  type = string
  default = "nyc3"
}

variable "cluster_name" {
  type = string
  default = "integration"
}

variable "environment" {
  type = string
  default = "production"
}

# K8s config
variable "k8s_version" {
  type  = string
  default = "1.21.3-do.0"
}