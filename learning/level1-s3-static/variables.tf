variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}

variable "bucket_name" {
  description = "Globally unique S3 bucket name"
  type        = string
}

variable "tags" {
  type = map(string)
  default = {
    Project = "terraform-learning"
    Level   = "1"
  }
}
