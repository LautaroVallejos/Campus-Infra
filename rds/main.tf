resource "aws_db_subnet_group" "rds-intranet" {
  name = "rds-private-subnet"
  description = "rds subnet group"
  subnet_ids = [var.db_subnet, var.private_subnet]

  tags = {
    Name = "Campus-Subnet-Group"
  }
}

resource "aws_security_group" "rds-firewall" {
  name   = "Campus-DB-Firewall"
  vpc_id = "${var.vpc_id}"
  description = "DB main firewall"

  tags = {
    Name = "RDS-Firewall"
  }
}


# Ingress Security Port 3306
resource "aws_security_group_rule" "rds-rules" {
  description = "Ingress rule to database"
  from_port         = 3306
  protocol          = "tcp"
  security_group_id = aws_security_group.rds-firewall.id
  to_port           = 3306
  type              = "ingress"
  cidr_blocks       = [var.cidr_block]
}

resource "mysql_role" "developer" {
  name = "developer"
}

resource "aws_db_instance" "campus-db" {
  allocated_storage           = 20
  storage_type                = "gp2"
  engine                      = "mysql"
  engine_version              = "5.7"
  instance_class              = var.db_instance
  db_name                     = var.db_name
  iam_database_authentication_enabled = true
  username                    = var.db_username
  password                    = var.db_password
  parameter_group_name        = "default.mysql5.7"
  db_subnet_group_name        = aws_db_subnet_group.rds-intranet.name
  vpc_security_group_ids      = [aws_security_group.rds-firewall.id]
  skip_final_snapshot         = true
  performance_insights_kms_key_id = "arn:aws:kms:sa-east-1:038298882203:key/5821ec1f-40b3-4f9d-add5-243d079ae81c"

#############################################
# Good practice, when you develop comment it!!
  deletion_protection = true # Comment and terraform apply to destroy db instance
  performance_insights_enabled = true 
  backup_retention_period = 35
  preferred_backup_window = "07:00-09:00"
  storage_encrypted  = true
  tags = {
    Name = "Campus-DB"
    id = "Campus-DB"
  }
}