resource "aws_vpc" "${var.name}" {
  cidr_block = "${var.cidr_block}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support = "${var.enable_dns_support}"
  tags {
    Name = "${var.name}"
	Owner = "${var.owner}"
  }
  lifecycle {
    create_before_destroy = true
  }
}