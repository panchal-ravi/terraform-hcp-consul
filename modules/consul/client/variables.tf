
variable "route_id" {
  description = "The ID of the HCP HVN route."
  type        = string
  default     = "hvn-rp-route"
}

variable "hvn_cidr_block" {
}

variable "region" {
}

variable "vpc_id" {
}

variable "vpc_cidr" {
}

variable "deployment_id" {}

variable "private_subnets" {
}

variable "eks_cluster_version" {
}

variable "eks_cluster_service_cidr" {
}

variable "eks_node_instance_type" {
}

variable "eks_node_desired_capacity" {
}

variable "hcp_consul_private_endpoint" {
}

variable "hcp_consul_public_endpoint" {
}

variable "hcp_consul_ca_file" {
}

variable "hcp_consul_root_token_secret_id" {
}

variable "consul_datacenter" {
}

variable "consul_version" {
}

variable "replicas" {
  default = 1
}

variable "partition_name" {
  default = "client1"
}

variable "helm_chart_version" {
}

variable "consul_gossip_encryption_key" {
}