data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = "ticketrail-tfstate-20261026"
    key    = "network/terraform.tfstate"
    region = "ap-northeast-2"
  }
}

module "tailscale_router" {
  source = "../../../modules/tailscale_router"

  vpc_id                  = data.terraform_remote_state.network.outputs.vpc_id
  private_subnet_ids      = data.terraform_remote_state.network.outputs.private_subnet_ids
  private_route_table_ids = data.terraform_remote_state.network.outputs.private_route_table_ids

  private_subnet_cidrs = var.private_subnet_cidrs
  router_private_ip    = var.router_private_ip
  onprem_cidr          = var.onprem_cidr
  aws_advertised_route = var.aws_advertised_route
}
