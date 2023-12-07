variable "state_bucket" {
  type        = string
  description = "The name of the S3 bucket to store the Terraform state file in"
}

variable "aws_access_key" {
  type        = string
  description = "The AWS access key to use for the AWS provider"
}

variable "aws_secret_key" {
  type        = string
  description = "The AWS secret key to use for the AWS provider"
}