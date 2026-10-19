# Existing Hybrid Network Remote State
data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = "ticketrail-tfstate-20261026"
    key    = "network/terraform.tfstate"
    region = "ap-northeast-2"
  }
}

# Reuse existing network resources
locals {
  vpc_id             = data.terraform_remote_state.network.outputs.vpc_id
  private_subnet_ids = data.terraform_remote_state.network.outputs.private_subnet_ids
}
