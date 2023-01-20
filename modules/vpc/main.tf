# VPC Configure
resource "aws_vpc" "campus_vpc" {
  cidr_block = "18.0.0.0/16"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"

  instance_tenancy     = "default"

  tags = {
    Name = "Campus-VPC-${var.environment}"
  }
}

# Public Subnet Settings (EC2)
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.campus_vpc.id
  cidr_block        = "18.0.12.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = var.availability_zone

  tags = {
    Name = "Campus-Public-Subnet-${var.environment}"
  }
}

# Private Subnet Setting (RDS)
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.campus_vpc.id
  cidr_block        = "18.0.23.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = var.availability_zone

  tags = {
    Name = "Campus-Private-Subnet-${var.environment}"
  }
}