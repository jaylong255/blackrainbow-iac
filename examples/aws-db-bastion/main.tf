# Create a terraform backend that accepts api keys and stores state in S3
terraform {
  backend "s3" {
    bucket = "cyber-terraform-state-us-east-1"
    key    = "blackrainbow-iac/examples/aws-db-bastion/terraform.tfstate"
    region = "us-east-1"
  }
}

# Configure the AWS provider
provider "aws" {
  region = "us-east-1"
  
  # authenticate using keys passed in from variables
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
}