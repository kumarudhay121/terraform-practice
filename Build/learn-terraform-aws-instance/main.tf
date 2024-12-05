terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_instance" "app_service" {
  ami           = "ami-001f2488b35ca8aad"
  instance_type = "t2.micro"
  tags = {
    Name = "ExampleAppServerInstance"
  }

}