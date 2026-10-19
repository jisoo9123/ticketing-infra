variable "aws_region" {
  description = "AWS region for Ticket Rail"
  type        = string
  default     = "ap-northeast-2"
}

variable "vpc_cidr" {
  description = "Ticket Rail VPC CIDR"
  type        = string
  default     = "10.20.0.0/16"
}

variable "availability_zones" {
  description = "Availability Zones used by Ticket Rail"
  type        = list(string)

  default = [
    "ap-northeast-2a",
    "ap-northeast-2b",
    "ap-northeast-2c"
  ]
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs"
  type        = list(string)

  default = [
    "10.20.0.0/24",
    "10.20.1.0/24",
    "10.20.2.0/24"
  ]
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs"
  type        = list(string)

  default = [
    "10.20.16.0/20",
    "10.20.32.0/20",
    "10.20.48.0/20"
  ]
}
