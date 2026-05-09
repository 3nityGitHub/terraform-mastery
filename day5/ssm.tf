# Store DB endpoint
resource "aws_ssm_parameter" "db_host" {
  name        = "/${var.project_name}/${var.environment}/db/host"
  description = "RDS PostgreSQL endpoint"
  type        = "String"
  value       = aws_db_instance.main.address

  tags = {
    Name = "${var.project_name}-db-host-${var.environment}"
  }
}

# Store DB name
resource "aws_ssm_parameter" "db_name" {
  name        = "/${var.project_name}/${var.environment}/db/name"
  description = "RDS database name"
  type        = "String"
  value       = var.db_name

  tags = {
    Name = "${var.project_name}-db-name-${var.environment}"
  }
}

# Store DB username
resource "aws_ssm_parameter" "db_username" {
  name        = "/${var.project_name}/${var.environment}/db/username"
  description = "RDS master username"
  type        = "String"
  value       = var.db_username

  tags = {
    Name = "${var.project_name}-db-username-${var.environment}"
  }
}

# Store DB password — SecureString encrypts with KMS
resource "aws_ssm_parameter" "db_password" {
  name        = "/${var.project_name}/${var.environment}/db/password"
  description = "RDS master password"
  type        = "SecureString"
  value       = var.db_password

  tags = {
    Name = "${var.project_name}-db-password-${var.environment}"
  }
}
