resource "aws_eip" "nat" {
  count = 1
}


module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~> 3.14.2"

  name = "${local.prefix}-vpc"
  cidr = local.vpc_cidr

  azs                 = local.azs
  private_subnets     = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  public_subnets      = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 4)]
  database_subnets    = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 8)]
  redshift_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 12)]

  enable_nat_gateway      = true
  single_nat_gateway      = true
  one_nat_gateway_per_az  = false
  reuse_nat_ips           = true
  external_nat_ip_ids     = aws_eip.nat.*.id

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${local.prefix}-vpc"
    Project = var.project_name
    Environment = var.environment
  }

}