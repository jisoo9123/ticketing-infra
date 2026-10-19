resource "rhcs_hcp_machine_pool" "workers_0" {
  cluster = module.rosa_hcp.cluster_id
  name    = "workers-0"

  subnet_id = "subnet-04e40c90d3a56ecba"

  autoscaling = {
    enabled      = true
    min_replicas = 1
    max_replicas = 2
  }

  auto_repair           = true
  ignore_deletion_error = false

  aws_node_pool = {
    instance_type            = "m5.xlarge"
    disk_size                = 75
    ec2_metadata_http_tokens = "required"
  }

  management = {
    type            = "Replace"
    max_surge       = "1"
    max_unavailable = "0"
  }
}

resource "rhcs_hcp_machine_pool" "workers_1" {
  cluster = module.rosa_hcp.cluster_id
  name    = "workers-1"

  subnet_id = "subnet-05a85f79f4896765f"

  autoscaling = {
    enabled      = true
    min_replicas = 1
    max_replicas = 2
  }

  auto_repair           = true
  ignore_deletion_error = false

  aws_node_pool = {
    instance_type            = "m5.xlarge"
    disk_size                = 75
    ec2_metadata_http_tokens = "required"
  }

  management = {
    type            = "Replace"
    max_surge       = "1"
    max_unavailable = "0"
  }
}

resource "rhcs_hcp_machine_pool" "workers_2" {
  cluster = module.rosa_hcp.cluster_id
  name    = "workers-2"

  subnet_id = "subnet-087370c4b0ac5da3a"

  autoscaling = {
    enabled      = true
    min_replicas = 1
    max_replicas = 2
  }

  auto_repair           = true
  ignore_deletion_error = false

  aws_node_pool = {
    instance_type            = "m5.xlarge"
    disk_size                = 75
    ec2_metadata_http_tokens = "required"
  }

  management = {
    type            = "Replace"
    max_surge       = "1"
    max_unavailable = "0"
  }
}
