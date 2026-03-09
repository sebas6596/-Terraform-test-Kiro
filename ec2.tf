# EC2 Instance in AZ 1a
resource "aws_instance" "web_1a" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private_1a.id
  vpc_security_group_ids = [aws_security_group.ec2.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Server Web 1a</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "${var.project_name}-server-web-1a"
  }
}

# EC2 Instance in AZ 1b
resource "aws_instance" "web_1b" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private_1b.id
  vpc_security_group_ids = [aws_security_group.ec2.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Server Web 1b</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "${var.project_name}-server-web-1b"
  }
}
