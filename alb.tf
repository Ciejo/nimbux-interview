resource "aws_alb" "alb" {
  name                      = "alb"
  security_groups           = ["${aws_security_group.alb-sg.id}"]
  subnets                   = aws_subnet.public.*.id
  tags = {
    Name = "ALB"
  }
}

# ALB target group
resource "aws_alb_target_group" "alb-tg" {
  name     = "Target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.vpc.id}"
  
}


# Target Group Attachment with Instances

resource "aws_alb_target_group_attachment" "nginx-attach" {
  target_group_arn = aws_alb_target_group.alb-tg.arn
  target_id        = aws_instance.nginx.id
  port = 80
}

resource "aws_alb_target_group_attachment" "apache-attach" {
  target_group_arn = aws_alb_target_group.alb-tg.arn
  target_id        = aws_instance.apache.id
  port = 80
}

# listener
resource "aws_alb_listener" "http_listener" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.alb-tg.arn}"
    type             = "forward"
  }
}

