provider "aws" {
  region = var.region
}


resource "aws_instance" "test_ec2" {
  instance_type = var.instance_type
  ami           = var.ami_id
  subnet_id     = var.subnet_id
  count = 1
}
