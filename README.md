Terraform AWS VPC Module
===========

A Terraform module to create the following resources within AWS:

- A Virtual Private Cloud (VPC)
- An Internet Gateway
- A set of public and private subnets - across availability zones within the region
- A public and a private route table - with routes connecting the respective subnets, and the internet gateway connected to the public subnet

Input Variables
---------------

- `name` - (Mandatory) The name of the VPC
- `cidr_block` - (Mandatory) The IP address range allocated to the VPC
- `owner` - (Optional) Owner tag added to the VPC in order to identify who built the resource, defaults to 'Terraform'
- `enable_dns_support` - (Optional) Whether or not the VPC has DNS support, defaults to 'false'
- `enable_dns_hostnames` - (Optional) Whether or not the VPC has DNS hostname support, defaults to 'false'
- `subnets_public` - (Mandatory) A comma separated list of public subnets, one for each availability zone
- `subnets_private` - (Mandatory) A comma separated list of private subnets, one for each availability zone
- `availability_zones` - (Mandatory) A comma separated list of availability zones to place the subnets into

Output Variables
----------------

- `id` - The VPC id
- `private_subnets` - The list of private subnets that are setup
- `public_subnets` - The list of public subnets that are setup
- `private_availability_zones` - The list of private availability zones that are setup
- `public_availability_zones` - The list of public availability zones that are setup

Usage
-----

```
module "my_vpc" {
  source = "github.com/mambetica/tf_aws_vpc"
  name = "${var.vpc_name}"
  cidr_block = "${var.vpc_cidr_block}"
  enable_dns_support = "${var.vpc_enable_dns_support}"
  subnets_public = "${var.vpc_subnets_public}"
  subnets_private = "${var.vpc_subnets_private}"
  availability_zones = "${var.vpc_availability_zones}"
}
```

With `variables`:

```
variable "vpc_name" { default = "MY_VPC" }
variable "vpc_cidr_block" { default = "10.10.0.0/16" }
variable "vpc_enable_dns_support" { default = true }
variable "vpc_subnets_public" { default = "10.10.0.0/20,10.10.16.0/20,10.10.32.0/20" }
variable "vpc_subnets_private" { default = "10.10.48.0/20,10.10.64.0/20,10.10.80.0/20" }
variable "vpc_availability_zones" { default = "region-1a,region-1b,region-1c" }
```