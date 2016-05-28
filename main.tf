resource "aws_vpc" "vpc" {
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

resource "aws_internet_gateway" "ig" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags {
    Name = "${var.name}"
    Owner = "${var.owner}"
  }
}

resource "aws_subnet" "private" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${element(split(",", var.subnets_private), count.index)}"
  availability_zone = "${element(split(",", var.availability_zones), count.index)}"
  tags {
    Name = "${element(split(",", var.availability_zones), count.index)}-private"
	Owner = "${var.owner}"
  }
  count = "${length(compact(split(",", var.subnets_private)))}"
}

resource "aws_subnet" "public" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${element(split(",", var.subnets_public), count.index)}"
  availability_zone = "${element(split(",", var.availability_zones), count.index)}"
  tags {
    Name = "${element(split(",", var.availability_zones), count.index)}-public"
    Owner = "${var.owner}"
  }
  count = "${length(compact(split(",", var.subnets_public)))}"
  map_public_ip_on_launch = true
}