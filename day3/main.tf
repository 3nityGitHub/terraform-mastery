# Tell Terraform which providers to use
terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    bucket         = "talium-terraform-state-29866"
    key            = "day3/terraform.tfstate"
    region         = "eu-west-2"
    use_lockfile   = true

    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }

  }
}

# Configure the AWS provider
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "talium-tech"
      Environment = var.environment
      ManagedBy   = "terraform"
      Owner       = "rapheal-okonta"
    }
  }
}
