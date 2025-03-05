resource "aws_launch_template" "web_tier_lt" {
    name_prefix = var.web_server_lt
    image_id = var.server_ami
    instance_type = var.server_instance_type
    vpc_security_group_ids = [aws_security_group.web_tier_sg.id]
    key_name = var.ssh_key_name

    user_data = base64encode(<<-EOF
        #!/bin/bash
        sudo apt update -y   # Use 'yum update -y' 
        sudo apt install -y nginx
        sudo systemctl start nginx
        sudo systemctl enable nginx
    EOF
    )
}   

resource "aws_alb" "web_alb" {
    internal = false 
    load_balancer_type = "application"
    security_groups = [aws_security_group.web_tier_sg.id]
    subnets = [aws_subnet.wt_pubs_1.id,aws_subnet.wt_pubs_2.id]
    enable_deletion_protection = false
    tags = {
      Name = "web_application_loadbalancer"
    }
}

resource "aws_lb_target_group" "web_tg" {
  name     = "web-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main_vpc.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "web_lb_listener" {
  load_balancer_arn = aws_alb.web_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

resource "aws_autoscaling_group" "web_asg" {
  vpc_zone_identifier = [ aws_subnet.wt_pubs_1.id,aws_subnet.wt_pubs_2.id]
  desired_capacity = 2
  min_size = 1
  max_size = 4

  launch_template {
    id = aws_launch_template.web_tier_lt.id
    version = "$Latest"
  }
  target_group_arns = [aws_lb_target_group.web_tg.arn]
  health_check_type = "EC2"
}
