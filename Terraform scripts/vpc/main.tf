provider "aws" {
  region = "us-east-1"  # Set your desired region
}

# Create VPC
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"  # Set your desired CIDR block for the VPC
}

# Create Internet Gateway
resource "aws_internet_gateway" "example" {
  vpc_id = aws_vpc.example.id
}

# Create Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "10.0.1.0/24"  # Set your desired CIDR block for the public subnet
  availability_zone = "us-east-1a"   # Set your desired availability zone for the subnet
}

# Create Route Table
resource "aws_route_table" "example" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example.id
  }
}

# Associate Subnet with Route Table
resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.example.id
}

