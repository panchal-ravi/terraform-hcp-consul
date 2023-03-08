terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.20.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.35.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.12.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "hcp" {
  client_id     = var.hcp_client_id
  client_secret = var.hcp_client_secret
}
