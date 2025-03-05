resource "aws_launch_template" "app_tier_lt" {
    name_prefix = var.app_server_lt
    image_id = var.server_ami
    instance_type = var.server_instance_type
    key_name = var.ssh_key_name

    network_interfaces {
      associate_public_ip_address = false 
      security_groups = [aws_security_group.app_tier_sg.id]
    }

    user_data = base64encode(<<-EOF
        #!/bin/bash
        sudo apt update -y  
        sudo apt install -y mysql
        sudo apt install -y nginx
        sudo systemctl start nginx
        sudo systemctl enable nginx
    EOF
    )
}

resource "aws_alb" "app_alb" {
    internal = true 
    load_balancer_type = "application"
    security_groups = [aws_security_group.app_tier_sg.id]
    subnets = [aws_subnet.appt_pris_1.id,aws_subnet.appt_pris_2.id]
    enable_deletion_protection = false
    tags = {
      Name = "app_application_loadbalancer"
    }
}


resource "aws_lb_target_group" "app_tg" {
  name     = "app-target-group"
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

resource "aws_lb_listener" "app_lb_listener" {
  load_balancer_arn = aws_alb.app_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}


resource "aws_autoscaling_group" "app_asg" {
  vpc_zone_identifier = [ aws_subnet.appt_pris_1.id,aws_subnet.appt_pris_2.id]
  desired_capacity = 2
  min_size = 1
  max_size = 4

  launch_template {
    id = aws_launch_template.app_tier_lt.id
    version = "$Latest"
  }
  target_group_arns = [aws_lb_target_group.app_tg.arn]
  health_check_type = "EC2"
}
