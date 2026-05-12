############################################
# RDS Outputs
############################################

output "db_endpoint" {
  description = "The connection endpoint for the RDS PostgreSQL instance."
  value       = aws_db_instance.postgres.address
}

output "db_port" {
  description = "The port the RDS instance is listening on."
  value       = aws_db_instance.postgres.port
}

output "db_identifier" {
  description = "The RDS instance identifier."
  value       = aws_db_instance.postgres.id
}

output "db_password_ssm_path" {
  description = "The SSM Parameter Store path where the DB password is stored."
  value       = var.db_password_ssm_path
}

