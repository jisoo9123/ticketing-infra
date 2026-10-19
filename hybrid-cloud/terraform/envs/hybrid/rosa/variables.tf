variable "cluster_name" {
  description = "ROSA HCP cluster name."
  type        = string
  default     = "ticketrail-hcp"
}

variable "region" {
  description = "AWS region for ROSA HCP."
  type        = string
  default     = "ap-northeast-2"
}

variable "openshift_version" {
  description = "Exact OpenShift 4.22 stable patch version for ROSA HCP."
  type        = string
}

variable "private" {
  description = "Whether the ROSA HCP cluster is private."
  type        = bool
  default     = false
}

variable "multi_az" {
  description = "Project design flag for Multi-AZ ROSA HCP."
  type        = bool
  default     = true
}

variable "availability_zones" {
  description = "Availability Zones used by the ROSA HCP cluster."
  type        = list(string)

  default = [
    "ap-northeast-2a",
    "ap-northeast-2b",
    "ap-northeast-2c"
  ]
}

variable "machine_cidr" {
  description = "Machine CIDR. Must match the AWS VPC CIDR."
  type        = string
  default     = "10.20.0.0/16"
}

variable "pod_cidr" {
  description = "ROSA Pod network CIDR."
  type        = string
  default     = "10.128.0.0/14"
}

variable "service_cidr" {
  description = "ROSA Service network CIDR."
  type        = string
  default     = "172.30.0.0/16"
}

variable "host_prefix" {
  description = "Host prefix used for Pod CIDR allocation per worker node."
  type        = number
  default     = 23
}

variable "compute_machine_type" {
  description = "Worker EC2 instance type."
  type        = string
  default     = "m5.xlarge"
}

variable "replicas" {
  description = "Initial total worker replicas for Multi-AZ ROSA HCP."
  type        = number
  default     = 3

  validation {
    condition     = var.replicas >= 3 && var.replicas % 3 == 0
    error_message = "replicas must be at least 3 and a multiple of 3 for this 3-AZ design."
  }
}

variable "worker_disk_size" {
  description = "Worker root disk size in GiB."
  type        = number
  default     = 75

  validation {
    condition     = var.worker_disk_size >= 75
    error_message = "worker_disk_size must be at least 75 GiB."
  }
}

variable "planned_min_workers" {
  description = "Planned total minimum workers after post-create autoscaling configuration."
  type        = number
  default     = 3
}

variable "planned_max_workers" {
  description = "Planned total maximum workers after post-create autoscaling configuration."
  type        = number
  default     = 6
}

variable "account_role_prefix" {
  description = "ROSA account role prefix."
  type        = string
  default     = "ticketrail"
}

variable "operator_role_prefix" {
  description = "ROSA operator role prefix."
  type        = string
  default     = "ticketrail-hcp"
}

variable "default_tags" {
  description = "Common project tags."
  type        = map(string)

  default = {
    project     = "ticketrail"
    environment = "hybrid"
    owner       = "jisu"
    managed_by  = "terraform"
    expires     = "2026-10-31"
  }
}
