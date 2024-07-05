# Create Security Group For EC2 Instances
resource "aws_security_group" "ec2_sg" {
  name          = "ec2-security-group"
  description   = "EC2 Security Group"
  vpc_id        = var.vpc_id
  tags          = {
    Name        = "${var.project}-ec2-sg"
  }
  
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
}