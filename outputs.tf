output "vpc_id" {
  description = "ID de la VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs de las subnets públicas"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs de las subnets privadas"
  value       = aws_subnet.private[*].id
}

output "alb_dns_name" {
  description = "DNS name del Application Load Balancer"
  value       = aws_lb.main.dns_name
}

output "alb_url" {
  description = "URL del Application Load Balancer"
  value       = "http://${aws_lb.main.dns_name}"
}

output "web_server_ids" {
  description = "IDs de las instancias EC2"
  value       = aws_instance.web_servers[*].id
}

output "web_server_private_ips" {
  description = "IPs privadas de las instancias EC2"
  value       = aws_instance.web_servers[*].private_ip
}
