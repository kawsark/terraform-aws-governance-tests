variable "owner" {
  description = "An Owner tag"
}

variable "aws_region" {
  description = "The AWS region this infrastructure should be provisioned in"
  default     = "us-east-2"
}

variable "environment" {
  default = "dev"
}

variable "App" {
  description = "value for App tag"
  default     = "mvd-app"
}

variable "vpc_cidr_block" {
  default = "192.168.0.0/16"
}

variable "public_subnet_1_block" {
  default = "192.168.0.0/21"
}
