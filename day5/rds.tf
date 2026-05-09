# DB Subnet Group — tells RDS which subnets to use
resource "aws_db_subnet_group" "main" {
  name        = "${var.project_name}-db-subnet-group-${var.environment}"
  subnet_ids  = data.aws_subnets.private.ids
  description = "DB subnet group for Talium RDS"

  tags = {
    Name = "${var.project_name}-db-subnet-group-${var.environment}"
  }
}

# RDS Parameter Group — PostgreSQL configuration
resource "aws_db_parameter_group" "main" {
  name        = "${var.project_name}-pg-params-${var.environment}"
  family      = "postgres15"
  description = "Custom parameter group for Talium PostgreSQL"

  parameter {
    name  = "log_connections"
    value = "1"
  }

  parameter {
    name  = "log_disconnections"
    value = "1"
  }

  tags = {
    Name = "${var.project_name}-pg-params-${var.environment}"
  }
}

# RDS PostgreSQL Instance
resource "aws_db_instance" "main" {
  identifier        = "${var.project_name}-postgres-${var.environment}"
  engine            = "postgres"
  engine_version    = "15.10"
  instance_class    = var.db_instance_class
  allocated_storage = 20
  storage_type      = "gp3"
  storage_encrypted = true

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  parameter_group_name   = aws_db_parameter_group.main.name

  # Backup configuration
  backup_retention_period = 7
  backup_window           = "03:00-04:00"
  maintenance_window      = "Mon:04:00-Mon:05:00"

  # For learning — skip final snapshot on destroy
  skip_final_snapshot       = true
  delete_automated_backups  = true

  # Disable public access — private subnet only
  publicly_accessible = false

  tags = {
    Name = "${var.project_name}-postgres-${var.environment}"
  }
}
