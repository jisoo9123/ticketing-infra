variable "aws_region" {
  description = "AWS region for Ticket Rail"
  type        = string
  default     = "ap-northeast-2"
}

variable "state_bucket_name" {
  description = "S3 bucket name for Terraform remote state"
  type        = string
  default     = "ticketrail-tfstate-20261026"
}
