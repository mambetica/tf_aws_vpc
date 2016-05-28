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
  count = "${length(compact(split(",", var.subnets_private)))}"
  tags {
    Name = "${aws_subnet.availability_zone.id}-private"
	Owner = "${var.owner}"
  }
}

resource "aws_subnet" "public" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${element(split(",", var.subnets_public), count.index)}"
  availability_zone = "${element(split(",", var.availability_zones), count.index)}"
  count = "${length(compact(split(",", var.subnets_public)))}"
  tags {
    Name = "${aws_subnet.availability_zone.id}-public"
    Owner = "${var.owner}"
  }
  map_public_ip_on_launch = true
}