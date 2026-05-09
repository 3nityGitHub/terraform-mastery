output "db_endpoint" {
  description = "RDS PostgreSQL endpoint"
  value       = aws_db_instance.main.address
}

output "db_port" {
  description = "RDS PostgreSQL port"
  value       = aws_db_instance.main.port
}

output "db_name" {
  description = "Database name"
  value       = aws_db_instance.main.db_name
}

output "ssm_db_host_path" {
  description = "SSM parameter path for DB host"
  value       = aws_ssm_parameter.db_host.name
}

output "bastion_public_ip" {
  description = "Public IP of bastion host"
  value       = aws_instance.bastion.public_ip
}
