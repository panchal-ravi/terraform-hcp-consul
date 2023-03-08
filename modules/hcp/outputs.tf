output "hvn_link" {
  value = hcp_hvn.this.self_link
}

output "hvn_cidr_block" {
  value = hcp_hvn.this.cidr_block
}

output "hcp_consul_private_endpoint_dc1" {
  value = hcp_consul_cluster.dc1.consul_private_endpoint_url
}

output "hcp_consul_public_endpoint_dc1" {
  value = hcp_consul_cluster.dc1.consul_public_endpoint_url
}

output "hcp_consul_ca_file_dc1" {
  value = hcp_consul_cluster.dc1.consul_ca_file
}

output "hcp_consul_root_token_secret_id_dc1" {
  value     = hcp_consul_cluster.dc1.consul_root_token_secret_id
  sensitive = true
}

output "hcp_consul_private_endpoint_dc2" {
  value = hcp_consul_cluster.dc2.consul_private_endpoint_url
}

output "hcp_consul_public_endpoint_dc2" {
  value = hcp_consul_cluster.dc2.consul_public_endpoint_url
}

output "hcp_consul_ca_file_dc2" {
  value = hcp_consul_cluster.dc2.consul_ca_file
}

output "hcp_consul_root_token_secret_id_dc2" {
  value     = hcp_consul_cluster.dc2.consul_root_token_secret_id
  sensitive = true
}

output "hcp_consul_version" {
  value = hcp_consul_cluster.dc1.consul_version
}
