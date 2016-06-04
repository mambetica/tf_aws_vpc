variable "name" {
  description = "The name of the VPC"
}
variable "cidr_block" {
  description = "The IP address range allocated to the VPC"
}
variable "owner" {
  description = "Owner tag added to the VPC in order to identify who built the resource, defaults to 'Terraform'"
  default = "Terraform"
}
variable "enable_dns_support" {
  description = "Whether or not the VPC has DNS support, defaults to 'false'"
  default = false
}
variable "enable_dns_hostnames" {
  description = "Whether or not the VPC has DNS hostname support, defaults to 'false'"
  default = false
}
variable "subnets_public" {
  description = "A comma separated list of public subnets, one for each availability zone"
}
variable "subnets_private" {
  description = "A comma separated list of private subnets, one for each availability zone"
}
variable "availability_zones" {
  description = "A comma separated list of availability zones to place the subnets into"
}