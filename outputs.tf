# Outputs
output "public_dns" {
  value = aws_instance.web_server.public_dns
}
output "public_ip" {
  value = aws_instance.web_server.public_ip
}

output "db_endpoint" {
  value = module.rds.db_endpoint
}

output "db_username" {
  value = module.rds.db_username
}

output "db_name" {
  value = module.rds.db_name
}