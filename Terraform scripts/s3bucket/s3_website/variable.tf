variable "region" {
  description = "region where you want to launch your resources"
  type = string
  default = "us-east-1"
}

variable "bucket-name" {
  description = "Name of the bucket where website will host"
  type = string
  default = "s3-static-7488"
}