module "sg-hcp-consul" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"

  name   = "${var.deployment_id}-hcp-consul-${var.partition_name}"
  vpc_id = var.vpc_id

  ingress_cidr_blocks = [var.hvn_cidr_block, var.vpc_cidr]
  ingress_rules       = ["consul-serf-lan-tcp", "consul-serf-lan-udp", "consul-tcp", "consul-grpc-tcp", "consul-dns-tcp",
  "consul-dns-udp", "https-443-tcp", "http-80-tcp", "http-8080-tcp", "https-8443-tcp", "consul-webui-https-tcp", "consul-webui-http-tcp"]

  egress_cidr_blocks = [var.hvn_cidr_block, var.vpc_cidr]
  egress_rules = ["consul-serf-lan-tcp", "consul-serf-lan-udp", "consul-tcp", "consul-grpc-tcp", "consul-dns-tcp",
  "consul-dns-udp", "https-443-tcp", "http-80-tcp", "http-8080-tcp", "https-8443-tcp", "consul-webui-https-tcp", "consul-webui-http-tcp"]

  ingress_with_cidr_blocks = [
    {
      from_port   = "20000"
      to_port     = "22000"
      protocol    = "tcp"
      cidr_blocks = var.hvn_cidr_block
    },
    {
      from_port   = "20000"
      to_port     = "22000"
      protocol    = "tcp"
      cidr_blocks = var.vpc_cidr
    }
  ]


  egress_with_cidr_blocks = [
    {
      from_port   = "20000"
      to_port     = "22000"
      protocol    = "tcp"
      cidr_blocks = var.hvn_cidr_block
    },
    {
      from_port   = "20000"
      to_port     = "22000"
      protocol    = "tcp"
      cidr_blocks = var.vpc_cidr
    }
  ]
}
