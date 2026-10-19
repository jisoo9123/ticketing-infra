variable "aws_region" {
  description = "AWS region for Ticket Rail"
  type        = string
  default     = "ap-northeast-2"
}

variable "router_private_ip" {
  description = "Fixed private IP of Tailscale Router"
  type        = string
  default     = "10.20.16.10"
}

variable "onprem_cidr" {
  description = "On-Prem LAN CIDR"
  type        = string
  default     = "10.1.93.0/24"
}

variable "aws_advertised_route" {
  description = "AWS VPC CIDR advertised through Tailscale"
  type        = string
  default     = "10.20.0.0/16"
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs allowed through Router SG"
  type        = list(string)

  default = [
    "10.20.16.0/20",
    "10.20.32.0/20",
    "10.20.48.0/20"
  ]
}
