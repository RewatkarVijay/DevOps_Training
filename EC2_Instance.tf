## To create EC2 instace
resource "aws_instance" "q1_web-01" {
 ami           = "ami-05f08ad7b78afd8cd" #ami-0af88851684f35a8c
 instance_type = "t2.micro"
 subnet_id = aws_subnet.q1_private_web.id
 key_name = "EC2PRODKeyPair"
 vpc_security_group_ids = [aws_security_group.allow_tls.id]

 tags = {
   Name = "Q1_Web-01"
 }
}

## To create EC2 instace
resource "aws_instance" "q1_web-02" {
 ami           = "ami-05f08ad7b78afd8cd" #ami-0af88851684f35a8c
 instance_type = "t2.micro"
 subnet_id = aws_subnet.q1_private_app.id
  key_name = "EC2PRODKeyPair"
  vpc_security_group_ids = [aws_security_group.allow_tls.id,aws_security_group.allow_all.id]

 tags = {
   Name = "Q1_Web-02"
 }
}

## Application Load Balancer
resource "aws_lb" "qa1_alb" {
  name               = "test-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_all.id]
  #subnets            = [for subnet in aws_subnet.DevSubnetPublic : subnet.id]
  #subnets            = [for subnet in aws_subnet.public : subnet.id]
  subnets            = [aws_subnet.q1_private_web.id,aws_subnet.q1_private_app.id]
  #enable_deletion_protection = true

#   access_logs {
#     bucket  = aws_s3_bucket.lb_logs.id
#     prefix  = "test-lb"
#     enabled = true
#   }

  tags = {
    Environment = "Training"
  }
}

## ALB Target Group
resource "aws_lb_target_group" "qa1_tg_alb" {
  name        = "tf-example-lb-alb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.q1_vpc.id
}

resource "aws_lb_target_group_attachment" "lb_tg_attach_web-01" {
  target_group_arn = aws_lb_target_group.alb-example.arn
  target_id        = aws_instance.web-01.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "lb_tg_attach_web-02" {
  target_group_arn = aws_lb_target_group.alb-example.arn
  target_id        = aws_instance.web-02.id
  port             = 80
}


resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.test_lb.arn
  port              = "80"
  protocol          = "HTTP"
  #ssl_policy        = "ELBSecurityPolicy-2016-08"
  #certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.qa1_tg_alb.arn
  }
}