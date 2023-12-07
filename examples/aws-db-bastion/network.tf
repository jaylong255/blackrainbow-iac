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
  public_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k + 4)]
  database_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k + 8)]

  create_database_subnet_group = true
  single_nat_gateway           = true
  one_nat_gateway_per_az       = false
  external_nat_ip_ids          = [aws_eip.nat_eip.id]
  enable_dns_hostnames         = true
  enable_nat_gateway           = true

  tags = {
    Name = "${local.project_name}-${local.environment}-vpc"
    Environment = local.environment
    Project = local.project_name
  }
}

resource "aws_eip" "nat_eip" {
  tags = {
    Name = "${local.project_name}-${local.environment}-nat-eip"
    Environment = local.environment
    Project = local.project_name
  }
}