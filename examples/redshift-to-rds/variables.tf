variable "aws_access_key" {
  type        = string
  description = "The AWS access key to use for the AWS provider"
}

variable "aws_secret_key" {
  type        = string
  description = "The AWS secret key to use for the AWS provider"
}

variable "aws_region" {
  type        = string
  description = "The AWS region to use for the AWS provider"
}

variable "project_name" {
  type        = string
  description = "The name of the project"
}

variable "environment" {
  type        = string
  description = "The environment to deploy to"
}