terraform{
  required_providers{
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  }

    ## To create EC2 instace
#resource "aws_instance" "example_server" {
#  ami           = "ami-0d188df7cedce7d90"
#  instance_type = "t2.micro"

 # tags = {
 #   Name = "EC2DT1Web01"
 # }
#}