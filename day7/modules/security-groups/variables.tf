variable "project_name" {
  description = "Project name used for tagging and naming."
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)."
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where security groups will be created."
  type        = string
}

variable "allowed_ingress_cidr" {
  description = "CIDR allowed to access public-facing components (e.g., ALB)."
  type        = string
  default     = "0.0.0.0/0"
}

variable "tags" {
  description = "Base tags applied to all security groups."
  type        = map(string)
  default     = {}
}

