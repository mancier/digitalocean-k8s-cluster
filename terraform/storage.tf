resource "digitalocean_volume" "database-volume" {
  region = var.do_region
  name = "${var.cluster_name}-${var.environment}"
  size = var.volume_size
  initial_filesystem_type = "ext4"
  tags = var.tags
}