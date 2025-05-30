resource "aws_security_group" "allow_ssh" {
  # vpc_id      = aws_vpc.main.id
  name        = "allow-ssh_${var.user_num}"
  description = "security group that allows ssh and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "ALL"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "allow-ssh_${var.user_num}"
    user_number = var.user_num
  }
}
