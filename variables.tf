variable "name" { }
variable "cidr_block" {}
variable "owner" {
  description = "Owner tag added to resource to identify who build the resource"
  default = "Terraform"
}
variable "enable_dns_support" {
  description = "Whether or not the VPC has DNS support"
  default = false
}
variable "enable_dns_hostnames" {
  description = "Whether or not the VPC has DNS hostname support"
  default = false
}