locals {
  vpc_cidr = "10.0.0.0/16"
  azs = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "v5.2.0"

  name = "${local.project_name}-${local.environment}-vpc"
  cidr = local.vpc_cidr
  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k)]

  tags = {
    Name = "${local.project_name}-${local.environment}-vpc"
    Environment = local.environment
    Project = local.project_name
  }
}