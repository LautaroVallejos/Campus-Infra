output "db_endpoint" {
  value = aws_db_instance.campus-db.endpoint
}

output "db_name" {
    value = aws_db_instance.campus-db.db_name
}

output "db_username" {
    value = aws_db_instance.campus-db.username
}