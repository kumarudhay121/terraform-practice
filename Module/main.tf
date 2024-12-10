terraform {
  backend "s3" {
    bucket = "terraform-practice-s3backend-bucket"
    region = "ap-southeast-2"
    key = "uday/terraform.tfstate"
    encrypt = true
    dynamodb_table = "table-for-state-locking"
  }
}


provider "aws" {
    region = "ap-southeast-2"
}

module "aws-instance-example" {
  source = "../Build/learn-terraform-aws-instance"
}

resource "aws_instance" "example2" {
  ami           = "ami-001f2488b35ca8aad"
  instance_type = "t2.micro"
  tags = {
    Name = "example2"
  }

}