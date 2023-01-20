output "public_subnet" {
    value = aws_subnet.public_subnet.id
}

output "firewall" {
    value = aws_security_group.firewall.id
}