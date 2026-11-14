terraform {
  required_version = "~>1.16.0"
  backend "s3" {
    bucket = "backend-bucket-terra123"
    key    = "terraform/state"
    region = "eu-north-1"
  }
}

provider "aws" {
  region = var.aws_region
}