variable "region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0bb84b8ffd87024d8"
}

variable "subnet_id" {
  description = "The subnet ID where the instance will be deployed"
  type        = string
  default     = "subnet-09d034e3314bad824"
}


