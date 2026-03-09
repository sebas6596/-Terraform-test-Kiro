terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Configuración para Terraform Cloud (descomentar y configurar)
  # cloud {
  #   organization = "tu-organizacion"
  #   workspaces {
  #     name = "aws-infrastructure"
  #   }
  # }
}

provider "aws" {
  region = var.aws_region
  
  # Terraform Cloud gestionará estas variables de entorno:
  # - AWS_ACCESS_KEY_ID
  # - AWS_SECRET_ACCESS_KEY
  # - AWS_DEFAULT_REGION
}

# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}
