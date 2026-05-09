variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-west-2"  # London
}

variable "environment" {
  description = "Environment name (dev, staging, production)"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
  default     = "talium"
}
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  description = "Availability zones to deploy subnets into"
  type        = list(string)
  default     = ["eu-west-2a", "eu-west-2b"]
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "talium"
}

variable "db_username" {
  description = "Database master username"
  type        = string
  default     = "taliumadmin"
}

variable "db_password" {
  description = "Database master password"
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "my_ip" {
  description = "Your public IP for SSH access"
  type        = string
  default     = "86.18.146.71/32"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "Amazon Machine Image ID"
  type        = string
  default     = "ami-0b45ae66668865cd6"
}
