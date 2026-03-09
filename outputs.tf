output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.main.dns_name
}

output "alb_url" {
  description = "URL of the Application Load Balancer"
  value       = "http://${aws_lb.main.dns_name}"
}

output "public_subnet_1a_id" {
  description = "Public subnet 1a ID"
  value       = aws_subnet.public_1a.id
}

output "public_subnet_1b_id" {
  description = "Public subnet 1b ID"
  value       = aws_subnet.public_1b.id
}

output "private_subnet_1a_id" {
  description = "Private subnet 1a ID"
  value       = aws_subnet.private_1a.id
}

output "private_subnet_1b_id" {
  description = "Private subnet 1b ID"
  value       = aws_subnet.private_1b.id
}

output "ec2_instance_1a_id" {
  description = "EC2 instance 1a ID"
  value       = aws_instance.web_1a.id
}

output "ec2_instance_1b_id" {
  description = "EC2 instance 1b ID"
  value       = aws_instance.web_1b.id
}
