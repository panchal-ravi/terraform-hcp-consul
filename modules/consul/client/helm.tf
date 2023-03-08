resource "local_file" "consul-client-helm-values" {
  content = templatefile("${path.root}/templates/consul/consul-client-helm.yml", {
    datacenter           = var.consul_datacenter
    consul_version       = var.consul_version
    replicas             = var.replicas
    partition_name       = var.partition_name
    consul_server_fqdn   = var.hcp_consul_private_endpoint
    cluster_api_endpoint = data.aws_eks_cluster.client.endpoint
  })
  filename = "${path.module}/consul-${var.partition_name}-helm-values.yml.tmp"

  depends_on = [
    consul_admin_partition.partitions
  ]
}


resource "helm_release" "consul-client" {
  name          = "rp-consul-${var.partition_name}"
  chart         = "consul"
  repository    = "https://helm.releases.hashicorp.com"
  version       = var.helm_chart_version
  namespace     = "consul"
  timeout       = "300"
  wait_for_jobs = true
  values = [
    local_file.consul-client-helm-values.content
  ]

  depends_on = [
    kubernetes_namespace.consul,
  ]
}