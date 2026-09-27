variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name prefix used for all resources"
  type        = string
  default     = "ecommerce"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "instance_type" {
  description = "EC2 instance type (2 GB RAM recommended for MongoDB + 5 Node containers)"
  type        = string
  default     = "t3.small"
}

variable "root_volume_size" {
  description = "Root EBS volume size in GB"
  type        = number
  default     = 20
}

variable "dockerhub_username" {
  description = "Docker Hub username/namespace that hosts the images"
  type        = string
}

variable "image_tag" {
  description = "Tag of the Docker images to deploy"
  type        = string
  default     = "v1"
}

variable "frontend_allowed_cidrs" {
  description = "CIDRs allowed to reach the frontend on HTTP port 80"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "backend_debug_cidrs" {
  description = "Optional extra CIDRs (e.g. your IP/32) allowed to reach backend ports 3001-3004 directly. Empty = internal (VPC) only."
  type        = list(string)
  default     = []
}
