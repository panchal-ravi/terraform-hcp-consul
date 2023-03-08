output "hcp_consul_private_endpoint_dc1" {
  value = module.hcp_cluster.hcp_consul_private_endpoint_dc1
}

output "hcp_consul_public_endpoint_dc1" {
  value = module.hcp_cluster.hcp_consul_public_endpoint_dc1
}

output "hcp_consul_private_endpoint_dc2" {
  value = module.hcp_cluster.hcp_consul_private_endpoint_dc2
}

output "hcp_consul_public_endpoint_dc2" {
  value = module.hcp_cluster.hcp_consul_public_endpoint_dc2
}
/* 
output "hcp_consul_ca_file" {
  value = module.hcp_cluster.hcp_consul_ca_file
} */

output "hcp_consul_root_token_secret_id_dc1" {
  value     = module.hcp_cluster.hcp_consul_root_token_secret_id_dc1
  sensitive = true
}


output "hcp_consul_root_token_secret_id_dc2" {
  value     = module.hcp_cluster.hcp_consul_root_token_secret_id_dc2
  sensitive = true
}