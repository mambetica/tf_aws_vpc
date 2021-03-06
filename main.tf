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

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags {
    Name = "public-${var.name}"
    Owner = "${var.owner}"
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.ig.id}"
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags {
    Name = "private-${var.name}"
    Owner = "${var.owner}"
  }
}

resource "aws_route_table" "data" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags {
    Name = "data-${var.name}"
    Owner = "${var.owner}"
  }
}

resource "aws_subnet" "public" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${element(split(",", var.subnets_public), count.index)}"
  availability_zone = "${element(split(",", var.availability_zones), count.index)}"
  tags {
    Name = "public-${var.name}-${element(split(",", var.availability_zone_ids), count.index)}"
    Owner = "${var.owner}"
  }
  count = "${length(compact(split(",", var.subnets_public)))}"
  map_public_ip_on_launch = false
}

resource "aws_subnet" "private" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${element(split(",", var.subnets_private), count.index)}"
  availability_zone = "${element(split(",", var.availability_zones), count.index)}"
  tags {
    Name = "private-${var.name}-${element(split(",", var.availability_zone_ids), count.index)}"
	Owner = "${var.owner}"
  }
  count = "${length(compact(split(",", var.subnets_private)))}"
  map_public_ip_on_launch = false
}

resource "aws_subnet" "data" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${element(split(",", var.subnets_data), count.index)}"
  availability_zone = "${element(split(",", var.availability_zones), count.index)}"
  tags {
    Name = "data-${var.name}-${element(split(",", var.availability_zone_ids), count.index)}"
    Owner = "${var.owner}"
  }
  count = "${length(compact(split(",", var.subnets_data)))}"
  map_public_ip_on_launch = false
}

resource "aws_route_table_association" "public" {
  count = "${length(compact(split(",", var.subnets_public)))}"
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "private" {
  count = "${length(compact(split(",", var.subnets_private)))}"
  subnet_id = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${aws_route_table.private.id}"
}

resource "aws_route_table_association" "data" {
  count = "${length(compact(split(",", var.subnets_data)))}"
  subnet_id = "${element(aws_subnet.data.*.id, count.index)}"
  route_table_id = "${aws_route_table.data.id}"
}