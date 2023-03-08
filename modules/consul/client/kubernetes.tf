resource "kubernetes_namespace" "consul" {
  metadata {
    name = "consul"
  }
}

resource "kubernetes_secret" "consul-ca-cert" {
  metadata {
    name      = "consul-ca-cert"
    namespace = "consul"
  }

  data = {
    "tls.crt" = var.hcp_consul_ca_file
  }

  depends_on = [
    kubernetes_namespace.consul
  ]
}

resource "kubernetes_secret" "consul-bootstrap-token" {
  metadata {
    name      = "consul-bootstrap-token"
    namespace = "consul"
  }

  data = {
    token = var.hcp_consul_root_token_secret_id
  }
}

resource "kubernetes_secret" "consul-gossip-encryption-key" {
  metadata {
    name      = "consul-gossip-encryption-key"
    namespace = "consul"
  }

  data = {
    key = var.consul_gossip_encryption_key
  }
}
