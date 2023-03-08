variable "hvn_id" {
}

variable "peering_id" {
}

variable "hvn_link" {
}

variable "route_id" {
  description = "The ID of the HCP HVN route."
  type        = string
  default     = "hvn-rp-route"
}

variable "hvn_cidr_block" {
}

variable "vpc_cidr" {
}

variable "deployment_id" {}

variable "public_subnets" {
}

variable "private_subnets" {
}
