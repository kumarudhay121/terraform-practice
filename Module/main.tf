terraform {
  backend "s3" {
    bucket = "terraform-practice-s3backend-bucket"
    region = "ap-southeast-2"
    key = "uday/terraform.tfstate"
  }
}


provider "aws" {
    region = "ap-southeast-2"
}

module "aws-instance-example" {
  source = "../Build/learn-terraform-aws-instance"
}