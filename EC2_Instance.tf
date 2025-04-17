    ## To create EC2 instace
resource "aws_instance" "E2DEVWEB-01" {
 ami           = "ami-0af88851684f35a8c"
 instance_type = "t2.micro"
 subnet_id = aws_subnet.dev_private_subnet.id

 tags = {
   Name = "E2DEVWEB-01"
 }
}

    ## To create EC2 instace
resource "aws_instance" "E2DEVWEB-02" {
 ami           = "ami-0af88851684f35a8c"
 instance_type = "t2.micro"
 subnet_id = aws_subnet.db_private_subnet.id
 
 tags = {
   Name = "E2DEVWEB-02"
 }
}