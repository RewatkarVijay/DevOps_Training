resource "aws_vpc" "test_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "test_vpc"
  }
}

resource "aws_subnet" "test_public_subnet" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "test_public_subnet"
  }
}

resource "aws_subnet" "test_private_subnet" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = "10.0.1.0/24"
   availability_zone = "us-east-1b"
  tags = {
    Name = "test_private_subnet"
  }
}