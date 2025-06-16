resource "aws_security_group" "eb_load_balancer" {
  name        = "${var.name_prefix}-eb_load_balancer-${var.env}-sg"
  description = "SG for Elastic Beanstalk load balancer (${var.name_prefix})"
  vpc_id      = var.vpc_id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.name_prefix}-eb_load_balancer-${var.env}-sg"
    Environment = var.env
  }
}

resource "aws_security_group" "eb_instances" {
  name        = "${var.name_prefix}-eb_instances-${var.env}-sg"
  description = "SG for Beanstalk EC2 instances (${var.name_prefix})"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.eb_load_balancer.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.name_prefix}-eb_instances-${var.env}-sg"
    Environment = var.env
  }
}
