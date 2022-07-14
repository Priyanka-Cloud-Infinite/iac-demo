provider "aws" {
  region = "ap-south-1"
}
resource "aws_security_group" "my_ec2_sg" {
  name   = "my_ec2_access"
  vpc_id = "vpc-0aa036557f34a7dad"

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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags={
  Name="Ec2-SG"
  }
}

resource "aws_instance" "My-instance" {
  ami                         = "${var.ami_id}"
  subnet_id                   = "subnet-06762400af542a38c"
  instance_type               = "${var.instance_type}"
  associate_public_ip_address = true
  security_groups             = [aws_security_group.my_ec2_sg.id]
  key_name =  "${var.keyname}"
}
