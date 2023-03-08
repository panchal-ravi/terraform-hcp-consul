resource "hcp_hvn" "this" {
  hvn_id         = var.hvn_id
  cloud_provider = var.cloud_provider
  region         = var.region
  cidr_block     = var.hvn_cidr_block
}

resource "hcp_consul_cluster" "dc1" {
  hvn_id             = hcp_hvn.this.hvn_id
  cluster_id         = "${var.cluster_id}-dc1"
  tier               = "development"
  public_endpoint    = true
  min_consul_version = "1.14.4"
}

resource "hcp_consul_cluster" "dc2" {
  hvn_id             = hcp_hvn.this.hvn_id
  cluster_id         = "${var.cluster_id}-dc2"
  tier               = "development"
  public_endpoint    = true
  min_consul_version = "1.14.4"
}