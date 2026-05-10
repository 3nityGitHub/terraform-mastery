variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  description = "VPC ID to create security groups in"
  type        = string
}

variable "my_ip" {
  description = "Your IP for SSH access"
  type        = string
}
