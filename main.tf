terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.1.0"
}

provider "aws" {
  region  = "us-west-2"
}

resource "aws_instance" "app_server" {
    key_name = "iac-micael"
    ami = "ami-0fcf52bcf5db7b003"
    instance_type = "t2.micro"

  tags = {
    Name = "MinhaMaquinaVirtual1"
  }
}
