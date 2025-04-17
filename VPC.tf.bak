resource "aws_vpc" "test_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "test_vpc"
  }
}

resource "aws_subnet" "dev_public_subnet" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "dev_public_subnet"
  }
}

resource "aws_subnet" "dev_private_subnet" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = "10.0.1.0/24"
   availability_zone = "us-east-1a"
  tags = {
    Name = "dev_private_subnet"
  }
}

resource "aws_subnet" "db_public_subnet" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "db_public_subnet"
  }
}

resource "aws_subnet" "db_private_subnet" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = "10.0.3.0/24"
   availability_zone = "us-east-1b"
  tags = {
    Name = "db_private_subnet"
  }
}