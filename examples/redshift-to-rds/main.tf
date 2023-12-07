# backend in aws s3, aws provider that authenticates with key and secret

terraform {
  backend "s3" {
    bucket = "cyber-terraform-state-us-east-1"
    key    = "blackrainbow-iac/examples/redshift-to-rds/terraform.tfstate"
    region = "us-east-1"
  }
  required_version = ">= 1.4.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.30.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key

}