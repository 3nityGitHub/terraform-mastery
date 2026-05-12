############################################
# Global Settings
############################################

variable "aws_region" {
  description = "AWS region to deploy infrastructure."
  type        = string
  default     = "eu-west-2"
}

variable "project_name" {
  description = "Project name used for naming and tagging."
  type        = string
  default     = "talium"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)."
  type        = string
  default     = "prod"
}

############################################
# VPC Configuration
############################################

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "List of availability zones to use."
  type        = list(string)
  default     = ["eu-west-2a", "eu-west-2b"]
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_app_subnet_cidrs" {
  description = "CIDR blocks for private application subnets."
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "private_db_subnet_cidrs" {
  description = "CIDR blocks for private database subnets."
  type        = list(string)
  default     = ["10.0.21.0/24", "10.0.22.0/24"]
}

############################################
# Security Groups
############################################

variable "allowed_ingress_cidr" {
  description = "CIDR allowed to access ALB (default: open internet)."
  type        = string
  default     = "0.0.0.0/0"
}

############################################
# RDS Configuration
############################################

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
  description = "SSM Parameter Store path for DB password."
  type        = string
  default     = "/talium/prod/db/password"
}

variable "db_instance_class" {
  description = "RDS instance class."
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Initial storage allocated to RDS."
  type        = number
  default     = 20
}

############################################
# Global Tags
############################################

variable "tags" {
  description = "Tags applied to all resources."
  type        = map(string)
  default = {
    Project     = "Talium"
    Environment = "prod"
    ManagedBy   = "Terraform"
  }
}

