terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region     = var.region
  profile = "default"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  env = terraform.workspace
  base_name = format("%s-%s",var.project_name, terraform.workspace)
  account_id = data.aws_caller_identity.current.account_id
  region = data.aws_region.current.name
}