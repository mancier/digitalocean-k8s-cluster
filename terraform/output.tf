output "kubeconfig" {
    sensitive = true
    value = digitalocean_kubernetes_cluster.integration_cluster.kube_config.0.raw_config
}