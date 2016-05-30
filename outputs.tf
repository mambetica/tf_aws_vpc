output "id" {
  value = "${aws_vpc.vpc.id}"
}
output "private_subnets" {
  value = "${join(",", aws_subnet.private.*.id)}"
}
output "public_subnets" {
  value = "${join(",", aws_subnet.public.*.id)}"
}