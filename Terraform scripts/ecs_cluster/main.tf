# define your provider
provider "aws" {
  region = "us-east-1" 
}

# create vpc

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_sub_1" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "public_sub_1"
  }
}

resource "aws_subnet" "public_sub_2" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "public_sub_2"
  }
}

resource "aws_subnet" "private_sub_1" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.3.0/24"
  tags = {
    Name = "private_sub_1"
  }
}

resource "aws_subnet" "private_sub_2" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.4.0/24"
  tags = {
    Name = "private_sub_2"
  }
}

resource "aws_internet_gateway" "my_internetgw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "ecs-igw"
  }
}

resource "aws_route_table" "my_route_table" {
   vpc_id = aws_vpc.my_vpc.id
   route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_internetgw.id
   }
}

resource "aws_route_table_association" "public" {
    route_table_id = aws_route_table.my_route_table.id
  subnet_id = aws_subnet.public_sub_1.id
}

resource "aws_route_table_association" "public1" {
    route_table_id = aws_route_table.my_route_table.id
  subnet_id = aws_subnet.public_sub_2.id
}

# Security group
resource "aws_security_group" "ecs_security_rroup" {
  vpc_id = aws_vpc.my_vpc.id
  ingress  {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ecs_security_rroup"
  }
}

# Create EKS Cluster
resource "aws_eks_cluster" "eks_cluster" {
  name     = "eks_cluster"
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids = [aws_subnet.example1.id, aws_subnet.example2.id]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.example-AmazonEKSVPCResourceController,
  ]
}

output "endpoint" {
  value = aws_eks_cluster.example.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.example.certificate_authority[0].data
}

