resource "aws_eip" "nat_eip" {
  #instance = aws_instance.web-01.id
  #domain   = "vpc"
  network_border_group = "us-east-1"
}
 
# Create the NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.q1_public_subnet.id
  #vpc_id        = aws_vpc.main.id
  tags = {
    Name = "my-nat-gateway"
  }
}
 