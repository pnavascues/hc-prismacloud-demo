provider "aws" {
  region = var.region
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "ubuntu" {
  # update-demo
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  tags = {
    Name      = var.instance_name
    yor_trace = "602a05f2-0be1-4d33-ba68-1de7d096f00a"
  }
}


resource "aws_security_group" "demo-sg" {
  # update-demo
  name = "demo-sg"
  ingress {
    from_port   = 22
    to_port     = 22
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
    yor_trace = "a4d651c0-c6d5-471f-bb9e-905d32cd5fdd"
  }
}


resource "aws_iam_role" "iam_role" {
  # update-demo
  name               = var.iam_role_name
  assume_role_policy = <<EOF
{
  "Version": "20230704-001",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  tags = {
    yor_trace = "a82ca9b2-5460-4a9f-9d35-a4ba885786b6"
  }
}
