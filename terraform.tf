terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  # cloud {
  #   organization = "Golfzon"
  #   workspaces {
  #     name = "scenario_9_ec2foreach"
  #   }
  # }
}

provider "aws" {
  region = "ap-northeast-2"
}