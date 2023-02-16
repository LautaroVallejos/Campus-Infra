output "public_subnet" {
  value = aws_subnet.public_subnet.id
}

output "firewall" {
  value = aws_security_group.firewall.id
}

output "private_subnet" {
  value = aws_subnet.private_subnet.id
}

output "db_subnet" {
  value = aws_subnet.db_subnet.id
}

output "vpc_id" {
  value = aws_vpc.campus_vpc.id
}

output "cidr_block" {
  value = aws_vpc.campus_vpc.cidr_block
}
