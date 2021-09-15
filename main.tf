terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

resource "aws_ecs_cluster" "main" {
  name = "development"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}


module "application" {
  source         = "./application"
  cluster        = aws_ecs_cluster.main
  vpc            = aws_vpc.main
  container_port = 5000
  desired_count  = 10

  application_name = "simpleflaskapp"
}

