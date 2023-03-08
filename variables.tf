variable "ttl" {
  description = "Resource TTL (time-to-live)"
  type        = number
  default     = 48
}

variable "aws_vpc_cidr" {
  description = "AWS VPC CIDR"
  type        = string
  default     = "10.200.0.0/16"
}

variable "aws_private_subnets" {
  description = "AWS private subnets"
  type        = list(string)
  default     = ["10.200.20.0/24", "10.200.21.0/24", "10.200.22.0/24"]
}

variable "aws_public_subnets" {
  description = "AWS public subnets"
  type        = list(string)
  default     = ["10.200.10.0/24", "10.200.11.0/24", "10.200.12.0/24"]
}

variable "hcp_region" {
}

variable "region" {
}

variable "eks_cluster_version" {
  description = "AWS EKS cluster version"
  type        = string
  default     = "1.24"
}

variable "eks_cluster_service_cidr" {
  description = "AWS EKS cluster service cidr"
  type        = string
  default     = "172.20.0.0/18"
}

variable "eks_node_instance_type" {
  description = "EKS self managed node instance type"
  type        = string
  default     = "m5.large"
}

variable "eks_node_desired_capacity" {
  description = "EKS self managed node desired capacity"
  type        = number
  default     = 2
}

variable "consul_helm_chart_version" {
  type        = string
  description = "Helm chart version"
  default     = "0.47.1"
}

variable "consul_version" {
  description = "Consul version"
  type        = string
  default     = "1.14.0-ent"
}

variable "consul_ent_license" {
  description = "Consul enterprise license"
  type        = string
  default     = ""
}

variable "consul_replicas" {
  description = "Number of Consul replicas"
  type        = number
  default     = 1
}

variable "consul_serf_lan_port" {
  description = "Consul serf lan port"
  type        = number
  default     = 9301
}

variable "peering_id" {
}

variable "hvn_id" {
}

variable "hvn_cidr_block" {
  default = "172.25.16.0/20"
}

variable "cloud_provider" {
  default = "aws"
}

variable "deployment_name" {
}

variable "hcp_client_id" {
}

variable "hcp_client_secret" {
}

variable "consul_gossip_encryption_key" {}

/* 
variable "partition_name" {
}
variable "aws_key_pair_key_name" {
} 
*/
