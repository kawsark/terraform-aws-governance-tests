provider "aws" {
  region = "${var.aws_region}"
}

data "aws_subnet" "selected" {
  id = "${var.subnet_id}"
}

resource "aws_instance" "ubuntu" {
  ami           = "${var.ami_id[var.aws_region]}"
  instance_type = "${var.instance_type}"
  subnet_id	= "${var.subnet_id}"

  tags {
    Env = "${var.environment}"
    Name = "${var.name}"
    owner = "${var.owner}"
    TTL = "${var.ttl}"
  }

}