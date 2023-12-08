data "aws_availability_zones" "available" {
  state = "available"
}

locals {
    prefix = "${var.project_name}-${var.environment}"
    region = var.aws_region
    vpc_cidr = "10.0.0.0/16"
    azs = slice(data.aws_availability_zones.available.names, 0, 3)
}