locals {
  deployment_id = lower("${var.deployment_name}-${random_string.suffix.result}")
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

module "hcp_cluster" {
  source         = "./modules/hcp"
  cluster_id     = local.deployment_id
  cloud_provider = "aws"
  hvn_id         = var.hvn_id
  region         = var.hcp_region
  hvn_cidr_block = var.hvn_cidr_block
}

module "aws" {
  source          = "./modules/aws/infra"
  hvn_id          = var.hvn_id
  hvn_cidr_block  = module.hcp_cluster.hvn_cidr_block
  peering_id      = var.peering_id
  hvn_link        = module.hcp_cluster.hvn_link
  vpc_cidr        = var.aws_vpc_cidr
  deployment_id   = local.deployment_id
  private_subnets = var.aws_private_subnets
  public_subnets  = var.aws_public_subnets
}

module "consul-client1-dc1" {
  source                          = "./modules/consul/client"
  vpc_id                          = module.aws.vpc_id
  vpc_cidr                        = var.aws_vpc_cidr
  deployment_id                   = local.deployment_id
  private_subnets                 = module.aws.private_subnets
  region                          = var.region
  partition_name                  = "client1"
  eks_cluster_service_cidr        = var.eks_cluster_service_cidr
  eks_node_desired_capacity       = var.eks_node_desired_capacity
  eks_node_instance_type          = var.eks_node_instance_type
  eks_cluster_version             = var.eks_cluster_version
  hvn_cidr_block                  = var.hvn_cidr_block
  hcp_consul_ca_file              = base64decode(module.hcp_cluster.hcp_consul_ca_file_dc1)
  hcp_consul_root_token_secret_id = module.hcp_cluster.hcp_consul_root_token_secret_id_dc1
  hcp_consul_private_endpoint     = trimprefix(module.hcp_cluster.hcp_consul_private_endpoint_dc1, "https://")
  hcp_consul_public_endpoint      = module.hcp_cluster.hcp_consul_public_endpoint_dc1
  consul_gossip_encryption_key    = var.consul_gossip_encryption_key
  consul_datacenter               = "${local.deployment_id}-dc1"
  helm_chart_version              = var.consul_helm_chart_version
  consul_version                  = var.consul_version //module.hcp_cluster.hcp_consul_version
}
/*
module "consul-client2-dc1" {
  source                          = "./modules/consul/client"
  vpc_id                          = module.aws.vpc_id
  vpc_cidr                        = var.aws_vpc_cidr
  deployment_id                   = local.deployment_id
  private_subnets                 = module.aws.private_subnets
  region                          = var.region
  partition_name                  = "client2"
  eks_cluster_service_cidr        = var.eks_cluster_service_cidr
  eks_node_desired_capacity       = var.eks_node_desired_capacity
  eks_node_instance_type          = var.eks_node_instance_type
  eks_cluster_version             = var.eks_cluster_version
  hvn_cidr_block                  = var.hvn_cidr_block
  hcp_consul_ca_file              = base64decode(module.hcp_cluster.hcp_consul_ca_file_dc1)
  hcp_consul_root_token_secret_id = module.hcp_cluster.hcp_consul_root_token_secret_id_dc1
  hcp_consul_private_endpoint     = trimprefix(module.hcp_cluster.hcp_consul_private_endpoint_dc1, "https://")
  hcp_consul_public_endpoint      = module.hcp_cluster.hcp_consul_public_endpoint_dc1
  consul_datacenter               = "${local.deployment_id}-dc1"
  helm_chart_version              = var.consul_helm_chart_version
  consul_version                  = module.hcp_cluster.hcp_consul_version
}

module "consul-client3-dc2" {
  source                          = "./modules/consul/client"
  vpc_id                          = module.aws.vpc_id
  vpc_cidr                        = var.aws_vpc_cidr
  deployment_id                   = local.deployment_id
  private_subnets                 = module.aws.private_subnets
  region                          = var.region
  partition_name                  = "client3"
  eks_cluster_service_cidr        = var.eks_cluster_service_cidr
  eks_node_desired_capacity       = var.eks_node_desired_capacity
  eks_node_instance_type          = var.eks_node_instance_type
  eks_cluster_version             = var.eks_cluster_version
  hvn_cidr_block                  = var.hvn_cidr_block
  hcp_consul_ca_file              = base64decode(module.hcp_cluster.hcp_consul_ca_file_dc2)
  hcp_consul_root_token_secret_id = module.hcp_cluster.hcp_consul_root_token_secret_id_dc2
  hcp_consul_private_endpoint     = trimprefix(module.hcp_cluster.hcp_consul_private_endpoint_dc2, "https://")
  hcp_consul_public_endpoint      = module.hcp_cluster.hcp_consul_public_endpoint_dc2
  consul_datacenter               = "${local.deployment_id}-dc2"
  helm_chart_version              = var.consul_helm_chart_version
  consul_version                  = module.hcp_cluster.hcp_consul_version
}
*/
