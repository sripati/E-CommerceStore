###############################################################################
# Networking: VPC, public subnet, Internet Gateway, route table
###############################################################################

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = { Name = "${var.project_name}-vpc" }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = { Name = "${var.project_name}-igw" }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = { Name = "${var.project_name}-public-subnet" }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = { Name = "${var.project_name}-public-rt" }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

###############################################################################
# Security Group
###############################################################################

resource "aws_security_group" "app" {
  name        = "${var.project_name}-app-sg"
  description = "Frontend HTTP from internet; backend ports 3001-3004 internal only"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP to frontend (nginx)"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.frontend_allowed_cidrs
  }

  ingress {
    description = "Internal service-to-service traffic (user/product/cart/order)"
    from_port   = 3001
    to_port     = 3004
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
    self        = true
  }

  dynamic "ingress" {
    for_each = length(var.backend_debug_cidrs) > 0 ? [1] : []
    content {
      description = "Optional direct backend access for debugging"
      from_port   = 3001
      to_port     = 3004
      protocol    = "tcp"
      cidr_blocks = var.backend_debug_cidrs
    }
  }

  egress {
    description = "All outbound (apt, Docker Hub pulls)"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.project_name}-app-sg" }
}

###############################################################################
# IAM role for SSM Session Manager (shell/commands without SSH or key pairs)
###############################################################################

resource "aws_iam_role" "ec2_ssm" {
  name = "${var.project_name}-ec2-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.ec2_ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ec2" {
  name = "${var.project_name}-ec2-profile"
  role = aws_iam_role.ec2_ssm.name
}

###############################################################################
# EC2 instance (Ubuntu 22.04) running all containers via user-data
###############################################################################

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "random_password" "jwt_secret" {
  length  = 32
  special = false
}

resource "aws_instance" "app" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.app.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2.name

  user_data = templatefile("${path.module}/user_data.sh.tftpl", {
    dockerhub_username = var.dockerhub_username
    image_tag          = var.image_tag
    jwt_secret         = random_password.jwt_secret.result
  })
  user_data_replace_on_change = true

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = "gp3"
    encrypted   = true
  }

  metadata_options {
    http_tokens = "required" # IMDSv2 only
  }

  tags = { Name = "${var.project_name}-app-server" }
}
