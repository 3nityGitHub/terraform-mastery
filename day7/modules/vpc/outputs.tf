############################################
# VPC Outputs
############################################

output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs."
  value       = [for s in aws_subnet.public : s.id]
}

output "private_app_subnet_ids" {
  description = "List of private application subnet IDs."
  value       = [for s in aws_subnet.private_app : s.id]
}

output "private_db_subnet_ids" {
  description = "List of private database subnet IDs."
  value       = [for s in aws_subnet.private_db : s.id]
}

output "db_subnet_group_name" {
  description = "Name of the DB subnet group for RDS."
  value       = aws_db_subnet_group.db.name
}

output "nat_gateway_ids" {
  description = "List of NAT Gateway IDs."
  value       = aws_nat_gateway.nat[*].id
}

output "igw_id" {
  description = "Internet Gateway ID."
  value       = aws_internet_gateway.igw.id
}

