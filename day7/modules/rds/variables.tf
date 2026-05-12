############################################
# RDS Module Variables
############################################

variable "project_name" {
  description = "Project name used for naming and tagging."
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the RDS instance will be deployed."
  type        = string
}

variable "subnet_ids" {
  description = "List of private DB subnet IDs for the DB subnet group."
  type        = list(string)
}

variable "db_subnet_group_name" {
  description = "Name of the DB subnet group created in the VPC module."
  type        = string
}

variable "db_sg_id" {
  description = "Security group ID for RDS PostgreSQL."
  type        = string
}

variable "db_name" {
  description = "Initial database name."
  type        = string
  default     = "taliumdb"
}

variable "db_username" {
  description = "Master username for RDS."
  type        = string
  default     = "taliumadmin"
}

variable "db_password_ssm_path" {
  description = "SSM Parameter Store path where the DB password will be stored."
  type        = string
}

variable "instance_class" {
  description = "RDS instance class."
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Initial storage allocated to RDS."
  type        = number
  default     = 20
}

variable "multi_az" {
  description = "Enable Multi-AZ deployment for high availability."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Base tags applied to all RDS resources."
  type        = map(string)
  default     = {}
}

