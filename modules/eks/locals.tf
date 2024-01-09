locals {
  environment = var.environment
  cluster_name = "ekstest"
  name = "${var.environment}"
  eks_cluster_name = "${local.name}-${var.cluster_name}"
}

