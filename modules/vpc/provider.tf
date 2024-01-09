terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 4.34.0"
    }
        kubernetes = {
          source  = "hashicorp/kubernetes"
          version = "= 2.12.1"   
        }
        helm = {
          source  = "hashicorp/helm"
          version = "= 2.6.0"   
        }
    random = {
      source  = "hashicorp/random"
      version = "= 3.3.2"
    }
    template = {
      source  = "hashicorp/template"
      version = "= 2.2.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "= 3.4.0"
    }
  }
}

provider "aws" {
  region = var.region
  assume_role {
    role_arn = "arn:aws:iam::${var.tenantaccount}:role/gks_devops"
  }
  default_tags {
    tags = {
      Project         = "GKS"
      ManagedBy       = "gks.devops@vodafone.com"
      TaggingVersion  = "V2.4"
      Confidentiality = "C3"
      Environment     = "TEST"
      SecurityZone    = "T"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
    
provider "kubernetes" {
  config_path    = "~/.kube/config"
}


