############################################
# Store DB Password in SSM Parameter Store
############################################

resource "aws_ssm_parameter" "db_password" {
  name        = var.db_password_ssm_path
  description = "Master password for RDS PostgreSQL"
  type        = "SecureString"
  value       = random_password.db_password.result

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-db-password"
  })
}

resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

############################################
# RDS PostgreSQL Instance
############################################

resource "aws_db_instance" "postgres" {
  identifier              = "${var.project_name}-${var.environment}-postgres"
  engine                  = "postgres"
  engine_version          = "15.10"
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  max_allocated_storage   = 100
  storage_type            = "gp3"
  storage_encrypted       = true

  db_name                 = var.db_name
  username                = var.db_username
  password                = random_password.db_password.result

  multi_az                = var.multi_az
  publicly_accessible     = false

  vpc_security_group_ids  = [var.db_sg_id]
  db_subnet_group_name    = var.db_subnet_group_name

  skip_final_snapshot     = false
  backup_retention_period = 7

  deletion_protection     = false

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-postgres"
  })
}

