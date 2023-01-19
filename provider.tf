# AWS Provider Config
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}



# Region Setting
provider "aws" {
  region = "us-east-1"
}