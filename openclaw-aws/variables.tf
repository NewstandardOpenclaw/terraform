variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-1"
}

variable "name_prefix" {
  description = "Resource name prefix"
  type        = string
  default     = "openclaw"
}

variable "vpc_id" {
  description = "Existing VPC ID"
  type        = string
}

variable "subnet_id" {
  description = "Existing subnet ID (public recommended if using public IP)"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.small"
}

variable "key_name" {
  description = "Optional EC2 key pair name"
  type        = string
  default     = null
}

variable "allowed_cidrs_ssh" {
  description = "CIDRs allowed to SSH"
  type        = list(string)
  default     = []
}

variable "associate_eip" {
  description = "Whether to create and associate an Elastic IP"
  type        = bool
  default     = false
}

variable "root_volume_size" {
  description = "Root EBS volume size (GiB)"
  type        = number
  default     = 30
}

variable "attach_instance_profile" {
  description = "Create/attach IAM instance profile to EC2"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Extra tags"
  type        = map(string)
  default     = {}
}
