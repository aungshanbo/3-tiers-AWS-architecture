#Web Server Security Group#

resource "aws_key_pair" "nginx_server_ssh_key" {
  key_name   = var.ssh_key_name
  public_key = file("~/.ssh/id_rsa.pub")
}

## Security Group for Web Tier ##
resource "aws_security_group" "web_tier_sg" {
  name        = var.web_security_group
  description = "Allow SSH, HTTP, and HTTPS access"
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web_tier_security_group"
  }
}

## Security Group for Application Tier ##

resource "aws_security_group" "app_tier_sg" {
  name = var.app_security_group
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    security_groups = [aws_security_group.web_tier_sg.id]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "app_tier_security_group"
  }
}

## Security Group for Database Tier ##

resource "aws_security_group" "db_tier_sg" {
    name = var.db_security_group
    description = "Allow MySQL Traffic from app server"
    vpc_id = aws_vpc.main_vpc.id

    ingress {
      from_port = 3306
      to_port = 3306
      protocol = "tcp"
      security_groups = [aws_security_group.app_tier_sg.id]
    }

    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
}