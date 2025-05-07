#To create VPC
resource "aws_vpc" "test_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "test_vpc"
  }
}

#To create subnet
resource "aws_subnet" "q1_public_subnet" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "q1_public_subnet"
  }
}

resource "aws_subnet" "q1_private_subnet" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = "10.0.1.0/24"
   availability_zone = "us-east-1a"
  tags = {
    Name = "q1_private_subnet"
  }
}

resource "aws_subnet" "q2_public_subnet" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "q2_public_subnet"
  }
}

resource "aws_subnet" "q2_private_subnet" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = "10.0.3.0/24"
   availability_zone = "us-east-1b"
  tags = {
    Name = "q2_private_subnet"
  }
}


#To create security groups
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.test_vpc.id
 
  tags = {

    Name = "allow_tls"

  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  #cidr_ipv4         = aws_vpc.main.cidr_block
  cidr_ipv4         = "0.0.0.0/0"
  #from_port         = 443
  ip_protocol       = "-1"
  #to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allows_RDP" {
  security_group_id = aws_security_group.allow_tls.id  
  #cidr_ipv4         = aws_vpc.main.cidr_block
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 3389
  ip_protocol       = "tcp"
  to_port           = 3389
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.test_vpc.id
 
   tags = {

    Name = "allow_all"

  }
}

resource "aws_internet_gateway" "igw_test1" {
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = "tf-igw"
  }
}

# Create Elastic IP resource.
resource "aws_eip" "nat_eip" {
  #instance = aws_instance.web-01.id
  #domain   = "vpc"
  network_border_group = "us-east-1"
}
 
# Create NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.q1_public_subnet.id
  #vpc_id        = aws_vpc.main.id
  tags = {
    Name = "qa1-nat-gateway"
  }
}
 