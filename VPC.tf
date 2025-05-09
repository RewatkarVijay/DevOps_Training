#To create VPC
resource "aws_vpc" "q1_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Q1_VPC"
  }
}

#To create subnet
resource "aws_subnet" "q1_public_web" {
  vpc_id     = aws_vpc.q1_vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "q1_public_web"
  }
}

resource "aws_subnet" "q1_private_web" {
  vpc_id     = aws_vpc.q1_vpc.id
  cidr_block = "10.0.1.0/24"
   availability_zone = "us-east-1a"
  tags = {
    Name = "q1_private_web"
  }
}

resource "aws_subnet" "q1_public_app" {
  vpc_id     = aws_vpc.q1_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "q1_public_app"
  }
}

resource "aws_subnet" "q1_private_app" {
  vpc_id     = aws_vpc.q1_vpc.id
  cidr_block = "10.0.3.0/24"
   availability_zone = "us-east-1b"
  tags = {
    Name = "q1_private_app"
  }
}

#To create security groups
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.q1_vpc.id
 
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
  vpc_id      = aws_vpc.q1_vpc.id
 
   tags = {
    Name = "allow_all"
  }
}

resource "aws_internet_gateway" "q1_igw" {
  vpc_id = aws_vpc.q1_vpc.id

  tags = {
    Name = "q1-igw"
  }
}

# To create Elastic IP resource.
resource "aws_eip" "nat_eip" {
  #instance = aws_instance.web-01.id
  #domain   = "vpc"
  network_border_group = "us-east-1"
}

# To create NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.q1_public_web.id
  #vpc_id        = aws_vpc.main.id
  tags = {
    Name = "qa1-nat-gateway"
  }
}


# Creating Route tables for Public Subnets
resource "aws_route_table" "qa1_public_route" {
  vpc_id = aws_vpc.q1_vpc.id
 
  route {
    cidr_block = aws_vpc.q1_vpc.cidr_block
    #network_interface_id = aws_network_interface.test_public.id
    gateway_id = aws_internet_gateway.q1_igw.id
  }
}
 
# associating route table with Public subnet 1
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.q1_public_web.id
  route_table_id = aws_route_table.qa1_public_route.id
}
 
resource "aws_route_table_association" "qa1_route_table_association" {
  subnet_id      = aws_subnet.q1_public_app.id
  route_table_id = aws_route_table.qa1_public_route.id
}
 
# # creating network interface for subnet
#  resource "aws_network_interface" "test_public" {
#    subnet_id = aws_subnet.q1_public_web.id
#  }
