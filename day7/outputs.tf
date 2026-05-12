############################################
# VPC Outputs
############################################

output "vpc_id" {
  description = "The ID of the VPC."
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs for load balancers or NAT gateways."
  value       = module.vpc.public_subnet_ids
}

output "private_app_subnet_ids" {
  description = "Private subnets for application workloads."
  value       = module.vpc.private_app_subnet_ids
}

output "private_db_subnet_ids" {
  description = "Private subnets for RDS."
  value       = module.vpc.private_db_subnet_ids
}

############################################
# Security Group Outputs
############################################

output "alb_sg_id" {
  description = "Security group ID for the ALB."
  value       = module.security_groups.alb_sg_id
}

output "app_sg_id" {
  description = "Security group ID for application instances."
  value       = module.security_groups.app_sg_id
}

output "db_sg_id" {
  description = "Security group ID for RDS."
  value       = module.security_groups.db_sg_id
}

############################################
# RDS Outputs
############################################

output "db_endpoint" {
  description = "RDS PostgreSQL endpoint."
  value       = module.rds.db_endpoint
}

output "db_port" {
  description = "RDS PostgreSQL port."
  value       = module.rds.db_port
}

output "db_password_ssm_path" {
  description = "SSM path where the DB password is stored."
  value       = module.rds.db_password_ssm_path
}

