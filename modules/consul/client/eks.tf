module "eks-consul-client" {
  source                          = "terraform-aws-modules/eks/aws"
  version                         = "18.26.3"
  cluster_name                    = "${var.deployment_id}-${var.partition_name}"
  cluster_version                 = var.eks_cluster_version
  vpc_id                          = var.vpc_id
  subnet_ids                      = var.private_subnets
  cluster_endpoint_private_access = true
  cluster_service_ipv4_cidr       = var.eks_cluster_service_cidr

  eks_managed_node_group_defaults = {
  }

  cluster_security_group_additional_rules = {
    ops_private_access_egress = {
      description = "Ops Private Egress"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "egress"
      cidr_blocks = [var.vpc_cidr]
    }
    ops_private_access_ingress = {
      description = "Ops Private Ingress"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      cidr_blocks = [var.vpc_cidr]
    }
  }

  eks_managed_node_groups = {
    client = {
      min_size               = 1
      max_size               = 3
      desired_size           = var.eks_node_desired_capacity
      instance_types         = [var.eks_node_instance_type]
      vpc_security_group_ids = [module.sg-hcp-consul.security_group_id]
      capacity_type          = "SPOT"
    }
  }

  tags = {
    Name = "${var.deployment_id}-${var.partition_name}"
  }
}


resource "null_resource" "kubeconfig" {

  provisioner "local-exec" {
    command = "aws eks --region ${var.region} update-kubeconfig --kubeconfig ${path.root}/${var.deployment_id}-kubeconfig --name ${module.eks-consul-client.cluster_id}"
  }

  depends_on = [
    module.eks-consul-client
  ]
}
