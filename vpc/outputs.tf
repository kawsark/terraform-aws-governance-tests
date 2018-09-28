output "vpc_id" {
  value = "${aws_vpc.mvd_vpc.id}"
}

output "vpc_tags" {
  value = "${aws_vpc.mvd_vpc.tags}"
}

output "subnet_id" {
  value = "${aws_subnet.mvd-public-1.id}"
}

output "subnet_arn" {
  value = "${aws_subnet.mvd-public-1.arn}"
}

output "subnet_tags" {
  value = "${aws_subnet.mvd-public-1.tags}"
}
