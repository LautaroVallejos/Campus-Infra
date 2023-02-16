# VPC Configure
resource "aws_vpc" "campus_vpc" {
  cidr_block           = "18.0.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  instance_tenancy = "default"

  tags = {
    Name = "Campus-VPC-${var.environment}"
  }
}

# Public Subnet Settings (EC2)
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.campus_vpc.id
  cidr_block              = "18.0.12.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.availability_zone[0]

  tags = {
    Name = "Campus-Public-Subnet-${var.environment}"
  }
}

# Private Subnet Setting (RDS A)
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.campus_vpc.id
  cidr_block              = "18.0.23.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = var.availability_zone[1]

  tags = {
    Name = "Campus-Private-SubnetA-${var.environment}"
  }
}

# Private Subnet Setting (RDS B)
resource "aws_subnet" "db_subnet" {
  vpc_id                  = aws_vpc.campus_vpc.id
  cidr_block              = "18.0.24.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = var.availability_zone[2]

  tags = {
    Name = "Campus-Private-SubnetB-${var.environment}"
  }
}

# Internet Gateway setting
resource "aws_internet_gateway" "internet_door" {
  vpc_id = aws_vpc.campus_vpc.id

  tags = {
    Name = "Campus-Internet-Gateway-${var.environment}"
  }
}

# Route Table
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.campus_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_door.id
  }

  tags = {
    Name = "Route Table"
  }
}

# Route Association
resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "private_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.route_table.id
}

# Security Group
resource "aws_security_group" "firewall" {
  vpc_id = aws_vpc.campus_vpc.id
  description = "Main security group for Campus plataform"
  ingress {
    description = "FTP Port"
    from_port   = 21
    to_port     = 21
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.campus_vpc.cidr_block]
  }
  ingress {
    description = "SSH Port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP Port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS Port"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

ingress {
    description = "Strapi port"
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Strapi Port"
  }
  

  ingress {
    description = "Postgresql port"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "egress rule"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.campus_vpc.cidr_block]
  }

  tags = {
    Name = "Campus-Firewall"
  }
}