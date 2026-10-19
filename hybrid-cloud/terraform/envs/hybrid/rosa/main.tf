# ============================================================
# Existing Network Stack
# ============================================================

data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = "ticketrail-tfstate-20261026"
    key    = "network/terraform.tfstate"
    region = "ap-northeast-2"
  }
}

# ============================================================
# Network values for ROSA HCP
# ============================================================

locals {
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id

  public_subnet_ids  = data.terraform_remote_state.network.outputs.public_subnet_ids
  private_subnet_ids = data.terraform_remote_state.network.outputs.private_subnet_ids

  # Public ROSA HCP Multi-AZ
  # Each AZ uses one Public and one Private subnet.
  rosa_subnet_ids = [
    local.public_subnet_ids[0],
    local.private_subnet_ids[0],

    local.public_subnet_ids[1],
    local.private_subnet_ids[1],

    local.public_subnet_ids[2],
    local.private_subnet_ids[2]
  ]
}

# ============================================================
# ROSA HCP
# ============================================================

module "rosa_hcp" {
  source  = "terraform-redhat/rosa-hcp/rhcs"
  version = "1.7.5"

  # ----------------------------------------------------------
  # Cluster
  # ----------------------------------------------------------

  cluster_name      = var.cluster_name
  openshift_version = var.openshift_version

  # Stable OpenShift release channel
  version_channel_group = "stable"

  private = var.private

  # ----------------------------------------------------------
  # Network
  # ----------------------------------------------------------

  machine_cidr = var.machine_cidr
  pod_cidr     = var.pod_cidr
  service_cidr = var.service_cidr
  host_prefix  = var.host_prefix

  aws_subnet_ids         = local.rosa_subnet_ids
  aws_availability_zones = var.availability_zones

  # ----------------------------------------------------------
  # Initial Worker Machine Pool
  # ----------------------------------------------------------

  compute_machine_type     = var.compute_machine_type
  replicas                 = var.replicas
  worker_disk_size         = var.worker_disk_size
  ec2_metadata_http_tokens = "required"

  # Default worker autoscaling is not enabled at cluster creation.
  # Planned autoscaling after cluster creation:
  # workers-0 : min 1 / max 2
  # workers-1 : min 1 / max 2
  # workers-2 : min 1 / max 2
  # total     : min 3 / max 6

  # ----------------------------------------------------------
  # IAM / OIDC
  # ----------------------------------------------------------

  create_account_roles = true
  account_role_prefix  = var.account_role_prefix

  create_oidc  = true
  managed_oidc = true

  create_operator_roles = true
  operator_role_prefix  = var.operator_role_prefix

  # ----------------------------------------------------------
  # Access / Ingress
  # ----------------------------------------------------------

  default_ingress_listening_method = "external"

  create_admin_user = false

  # ----------------------------------------------------------
  # Tags
  # ----------------------------------------------------------

  tags = var.default_tags
}
