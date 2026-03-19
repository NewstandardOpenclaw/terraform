locals {
  common_tags = merge({
    Name      = "${var.name_prefix}-ec2"
    ManagedBy = "terraform"
    Service   = "openclaw"
  }, var.tags)
}

resource "aws_security_group" "openclaw" {
  name_prefix = "${var.name_prefix}-sg-"
  description = "OpenClaw EC2 security group"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidrs_ssh
  }

  # OpenClaw gateway default UI/API port (loopback by default; keep closed publicly)
  # Add ingress rule only if you intentionally expose it via trusted network/proxy.

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, { Name = "${var.name_prefix}-sg" })
}

resource "aws_iam_role" "openclaw" {
  count = var.attach_instance_profile ? 1 : 0
  name = "${var.name_prefix}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })

  tags = local.common_tags
}

resource "aws_iam_instance_profile" "openclaw" {
  count = var.attach_instance_profile ? 1 : 0
  name = "${var.name_prefix}-ec2-profile"
  role = aws_iam_role.openclaw[0].name

  tags = local.common_tags
}

resource "aws_instance" "openclaw" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.openclaw.id]
  key_name                    = var.key_name
  iam_instance_profile        = var.attach_instance_profile ? aws_iam_instance_profile.openclaw[0].name : null
  associate_public_ip_address = !var.associate_eip

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = "gp3"
    encrypted   = true
  }

  tags = local.common_tags
}

resource "aws_eip" "openclaw" {
  count    = var.associate_eip ? 1 : 0
  domain   = "vpc"
  instance = aws_instance.openclaw.id

  tags = merge(local.common_tags, { Name = "${var.name_prefix}-eip" })
}
