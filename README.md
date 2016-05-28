Terraform AWS VPC Module
===========

A Terraform module to create a Virtual Private Cloud (VPC) within AWS.

Input Variables
---------------

- `name` - (Mandatory) The name of the VPC
- `cidr_block` - (Mandatory) The IP address range allocated to the VPC
- `owner` - (Optional) Owner tag added to the VPC in order to identify who built the resource, defaults to 'Terraform'
- `enable_dns_support` - (Optional) Whether or not the VPC has DNS support, defaults to 'false'
- `enable_dns_hostnames` - (Optional) Whether or not the VPC has DNS hostname support, defaults to 'false'