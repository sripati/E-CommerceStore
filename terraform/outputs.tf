output "frontend_url" {
  description = "Public URL of the e-commerce frontend"
  value       = "http://${aws_instance.app.public_ip}"
}

output "frontend_public_dns_url" {
  description = "Public DNS URL of the e-commerce frontend"
  value       = "http://${aws_instance.app.public_dns}"
}

output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.app.public_ip
}

output "public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.app.public_dns
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.app.id
}

output "vpc_id" {
  description = "ID of the provisioned VPC"
  value       = aws_vpc.main.id
}

output "backend_status_urls" {
  description = "Backend sample responses, reachable publicly via the frontend's nginx proxy"
  value = {
    frontend = "http://${aws_instance.app.public_ip}/health"
    user     = "http://${aws_instance.app.public_ip}/services/user/"
    product  = "http://${aws_instance.app.public_ip}/services/product/"
    cart     = "http://${aws_instance.app.public_ip}/services/cart/"
    order    = "http://${aws_instance.app.public_ip}/services/order/"
  }
}

output "ssm_session_command" {
  description = "Open a shell on the instance without SSH (needs the AWS Session Manager plugin)"
  value       = "aws ssm start-session --target ${aws_instance.app.id} --region ${var.aws_region}"
}
