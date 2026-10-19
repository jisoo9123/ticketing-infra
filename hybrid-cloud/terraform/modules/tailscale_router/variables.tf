variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "private_route_table_ids" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "router_private_ip" {
  type = string
}

variable "onprem_cidr" {
  type = string
}

variable "aws_advertised_route" {
  type = string
}
