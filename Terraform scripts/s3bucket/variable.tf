variable "region" {
  description = "The AWS region to deploy to"
  type        = string
}


variable "project_name" {
  description = "The terraform project"
  type        = string
  default     = "us-east-1"

}

variable "s3" {
  description = "s3 bucket resource"
  type = string
  default = "aws-s3-bucket-7488"
}