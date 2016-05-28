Terraform Module - AWS VPC
===========

A Terraform module to create a Virtual Private Cloud within AWS.

Input Variables
---------------

- 'name' - The name of the VPC
- 'cidr_block' - The IP address range allocated to the VPC
- 'owner' - Owner tag added to resource to identify who build the resource
- 'enable_dns_support' - Whether or not the VPC has DNS support
- 'enable_dns_hostnames' - Whether or not the VPC has DNS hostname support