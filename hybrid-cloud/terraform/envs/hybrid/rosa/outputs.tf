# ============================================================
# ROSA HCP Cluster Outputs
# ============================================================

output "cluster_id" {
  description = "Unique identifier of the ROSA HCP cluster."
  value       = module.rosa_hcp.cluster_id
}

output "cluster_state" {
  description = "Current state of the ROSA HCP cluster."
  value       = module.rosa_hcp.cluster_state
}

output "cluster_api_url" {
  description = "ROSA HCP API server URL."
  value       = module.rosa_hcp.cluster_api_url
}

output "cluster_console_url" {
  description = "ROSA HCP web console URL."
  value       = module.rosa_hcp.cluster_console_url
}

output "cluster_current_version" {
  description = "Current OpenShift version of the ROSA HCP cluster."
  value       = module.rosa_hcp.cluster_current_version
}

output "cluster_channel" {
  description = "OpenShift update channel used by the ROSA HCP cluster."
  value       = module.rosa_hcp.cluster_channel
}

output "cluster_domain" {
  description = "DNS domain assigned to the ROSA HCP cluster."
  value       = module.rosa_hcp.cluster_domain
}

# ============================================================
# IAM / OIDC Outputs
# ============================================================

output "account_role_prefix" {
  description = "Prefix used for ROSA account-wide IAM roles."
  value       = module.rosa_hcp.account_role_prefix
}

output "operator_role_prefix" {
  description = "Prefix used for ROSA cluster-specific operator roles."
  value       = module.rosa_hcp.operator_role_prefix
}

output "oidc_config_id" {
  description = "OIDC configuration ID used by the ROSA HCP cluster."
  value       = module.rosa_hcp.oidc_config_id
}

# ============================================================
# Network Outputs
# ============================================================

output "vpc_id" {
  description = "VPC ID used by the ROSA HCP cluster."
  value       = local.vpc_id
}

output "rosa_subnet_ids" {
  description = "Public and private subnet IDs passed to ROSA HCP."
  value       = local.rosa_subnet_ids
}

output "availability_zones" {
  description = "Availability Zones used by the Multi-AZ ROSA HCP cluster."
  value       = var.availability_zones
}

# ============================================================
# Worker Configuration Outputs
# ============================================================

output "initial_worker_replicas" {
  description = "Initial total number of ROSA HCP workers."
  value       = var.replicas
}

output "compute_machine_type" {
  description = "EC2 instance type used by the initial worker pools."
  value       = var.compute_machine_type
}

output "worker_disk_size" {
  description = "Worker root disk size in GiB."
  value       = var.worker_disk_size
}

# These are project design targets.
# They are NOT applied to the default worker pools during initial cluster creation.

output "planned_min_workers" {
  description = "Planned total minimum workers after post-create autoscaling configuration."
  value       = var.planned_min_workers
}

output "planned_max_workers" {
  description = "Planned total maximum workers after post-create autoscaling configuration."
  value       = var.planned_max_workers
}
