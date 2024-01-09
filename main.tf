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
  region = "eu-central-1"
  assume_role {
    role_arn = "arn:aws:iam::618*:role/g_devops"
  }
  default_tags {
    tags = {
      Project         = "eks"
      ManagedBy       = "bh@one.com"
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


##### vpc Module #####

module "vpc_resources" {
  source = "./modules/vpc"
  project = "eks"
  tenantaccount = "618*"
  environment = "dev"
}

module "eks_resources" {
  source = "./modules/eks"
  public_subnets = module.vpc_resources.public_subnet_ids
  cluster_name = "eksdemo1"
  cluster_service_ipv4_cidr = "172.20.0.0/16"
  cluster_version = "1.26"
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access = true
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]
}
