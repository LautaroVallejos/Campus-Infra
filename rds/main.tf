resource "aws_db_subnet_group" "rds-intranet" {
  name = "rds-private-subnet"
  subnet_ids = [var.db_subnet, var.private_subnet]

  tags = {
    Name = "Campus-Subnet-Group"
  }
}

resource "aws_security_group" "rds-firewall" {
  name   = "Campus-DB-Firewall"
  vpc_id = "${var.vpc_id}"

  tags = {
    Name = "RDS-Firewall"
  }
}


# Ingress Security Port 3306
resource "aws_security_group_rule" "rds-rules" {
  from_port         = 3306
  protocol          = "tcp"
  security_group_id = aws_security_group.rds-firewall.id
  to_port           = 3306
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_db_instance" "campus-db" {
  allocated_storage           = 20
  storage_type                = "gp2"
  engine                      = "mysql"
  engine_version              = "5.7"
  instance_class              = var.db_instance
  db_name                     = var.db_name
  username                    = var.db_username
  password                    = var.db_password
  parameter_group_name        = "default.mysql5.7"
  db_subnet_group_name        = aws_db_subnet_group.rds-intranet.name
  vpc_security_group_ids      = [aws_security_group.rds-firewall.id]
  skip_final_snapshot         = true
  # deletion_protection = true # Comment and terraform apply to destroy db instance

  tags = {
    Name = "Campus-DB"
    id = "Campus-DB"
  }
}