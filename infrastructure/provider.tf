terraform {
  required_version = "~>1.16.0"
  backend "s3" {
    bucket  = "backend-bucket-terra123"
    key     = "terraform/state"
    region  = "eu-north-1"
    profile = "bailukdmytro@gmail.com"
  }
}

provider "aws" {
  region  = "eu-north-1"
  profile = "bailukdmytro@gmail.com"
}