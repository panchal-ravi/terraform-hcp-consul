data "aws_eks_cluster" "client" {
  name = module.eks-consul-client.cluster_id
}

data "aws_eks_cluster_auth" "client" {
  name = module.eks-consul-client.cluster_id
}


provider "kubernetes" {
  host                   = data.aws_eks_cluster.client.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.client.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.client.token
}


provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.client.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.client.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.client.token
  }
}

provider "consul" {
  address    = var.hcp_consul_public_endpoint
  token      = var.hcp_consul_root_token_secret_id
  scheme     = "https"
  datacenter = var.consul_datacenter
}
