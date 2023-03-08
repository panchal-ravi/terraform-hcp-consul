data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"

  name                 = var.deployment_id
  cidr                 = var.vpc_cidr
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = var.private_subnets
  public_subnets       = var.public_subnets
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/${var.deployment_id}-client1" = "shared"
    "kubernetes.io/cluster/${var.deployment_id}-client2" = "shared"
    "kubernetes.io/cluster/${var.deployment_id}-client3" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.deployment_id}-client1" = "shared"
    "kubernetes.io/cluster/${var.deployment_id}-client2" = "shared"
    "kubernetes.io/cluster/${var.deployment_id}-client3" = "shared"
    "kubernetes.io/role/elb"                             = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.deployment_id}-client1" = "shared"
    "kubernetes.io/cluster/${var.deployment_id}-client2" = "shared"
    "kubernetes.io/cluster/${var.deployment_id}-client3" = "shared"
    "kubernetes.io/role/internal-elb"                    = "1"
  }
}

data "aws_arn" "peer" {
  arn = module.vpc.vpc_arn
}

resource "hcp_aws_network_peering" "peer" {
  hvn_id          = var.hvn_id
  peering_id      = var.peering_id
  peer_vpc_id     = module.vpc.vpc_id
  peer_account_id = module.vpc.vpc_owner_id
  peer_vpc_region = data.aws_arn.peer.region
}

resource "hcp_hvn_route" "peer_route" {
  hvn_link         = var.hvn_link
  hvn_route_id     = var.route_id
  destination_cidr = module.vpc.vpc_cidr_block
  target_link      = hcp_aws_network_peering.peer.self_link
}

resource "aws_vpc_peering_connection_accepter" "peer" {
  vpc_peering_connection_id = hcp_aws_network_peering.peer.provider_peering_id
  auto_accept               = true
}

data "aws_route_table" "peer_private" {
  vpc_id = module.vpc.vpc_id

  tags = {
    Name = "${var.deployment_id}-private"
  }
}

data "aws_route_table" "peer_public" {
  vpc_id = module.vpc.vpc_id

  tags = {
    Name = "${var.deployment_id}-public"
  }
}

resource "aws_route" "peer_route_private" {
  route_table_id            = data.aws_route_table.peer_private.id
  destination_cidr_block    = var.hvn_cidr_block
  vpc_peering_connection_id = hcp_aws_network_peering.peer.provider_peering_id
}

resource "aws_route" "peer_route_public" {
  route_table_id            = data.aws_route_table.peer_public.id
  destination_cidr_block    = var.hvn_cidr_block
  vpc_peering_connection_id = hcp_aws_network_peering.peer.provider_peering_id
}
