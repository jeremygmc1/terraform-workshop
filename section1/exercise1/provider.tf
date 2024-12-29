# terraform block to define terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # will download latest if not set
    }
  }

  required_version = ">= 1.2.0" # sets terraform CLI version
}

# configures the AWS provider with the region set to ap-southeast-1
provider "aws" {
  region = "ap-southeast-1"
}