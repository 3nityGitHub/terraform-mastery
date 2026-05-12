############################################
# Terraform Backend (Remote State + Locking)
############################################

terraform {
  backend "s3" {
    bucket         = "talium-terraform-state-29866"
    key            = "day7/production/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "talium-terraform-locks"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

############################################
# AWS Provider
############################################

provider "aws" {
  region = var.aws_region
}

############################################
# VPC Module
############################################

module "vpc" {
  source = "./modules/vpc"

  project_name              = var.project_name
  environment               = var.environment
  vpc_cidr                  = var.vpc_cidr
  azs                       = var.azs
  public_subnet_cidrs       = var.public_subnet_cidrs
  private_app_subnet_cidrs  = var.private_app_subnet_cidrs
  private_db_subnet_cidrs   = var.private_db_subnet_cidrs
  enable_nat_gateway        = true

  tags = var.tags
}

############################################
# Security Groups Module
############################################

module "security_groups" {
  source = "./modules/security-groups"

  project_name        = var.project_name
  environment         = var.environment
  vpc_id              = module.vpc.vpc_id
  allowed_ingress_cidr = var.allowed_ingress_cidr

  tags = var.tags
}

############################################
# RDS Module
############################################

module "rds" {
  source = "./modules/rds"

  project_name           = var.project_name
  environment            = var.environment
  vpc_id                 = module.vpc.vpc_id
  subnet_ids             = module.vpc.private_db_subnet_ids
  db_subnet_group_name   = module.vpc.db_subnet_group_name
  db_sg_id               = module.security_groups.db_sg_id

  db_name                = var.db_name
  db_username            = var.db_username
  db_password_ssm_path   = var.db_password_ssm_path
  instance_class         = var.db_instance_class
  allocated_storage      = var.db_allocated_storage
  multi_az               = true

  tags = var.tags
}

