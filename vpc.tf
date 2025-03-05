resource "aws_vpc" "main_vpc" {
    cidr_block = var.main_vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
      Name = "main_vpc"
    }
}