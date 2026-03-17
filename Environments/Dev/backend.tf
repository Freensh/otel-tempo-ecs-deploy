terraform {
  required_version = ">= 1.9.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.49.0"
    }
  }

  backend "s3" {
    bucket         = "freensh-cluster-backend"
    region         = "ca-central-1"
    key            = "ecs/terraform.tfstate"
    dynamodb_table = "state-backend"
    encrypt        = true
  }
}

provider "aws" {
  region = var.region
}