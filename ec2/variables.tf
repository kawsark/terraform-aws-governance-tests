variable "owner" {
  description = "An Owner tag"
}

variable "aws_region" {
  description = "The AWS region this infrastructure should be provisioned in"
  default     = "us-east-2"
}

variable "subnet_id" {
  description = "An existing subnet id where this EC2 instance should be provisioned"
}

variable "environment" {
  default = "Production"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami_id" {
  description = "ID of the AMI to provision. Default is Ubuntu 14.04 Base Image"
  type        = "map"

  default = {
    us-east-1 = "ami-759bc50a"
    us-east-2 = "ami-5e8bb23b"
  }
}

variable "App" {
  default = "mvd-app"
}

variable "name" {
  description = "name to pass to Name tag"
  default     = "mvd-server"
}

variable "ttl" {
  description = "A desired time to live (not enforced via terraform)"
  default     = "24"
}