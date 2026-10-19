# =========================================
# ElastiCache Subnet Group
# =========================================
resource "aws_elasticache_subnet_group" "valkey" {
  name       = "ticketrail-full-valkey-subnets"
  subnet_ids = local.private_subnet_ids

  tags = {
    Name = "ticketrail-full-valkey-subnets"
  }
}

# =========================================
# ElastiCache Parameter Group
# =========================================
resource "aws_elasticache_parameter_group" "valkey" {
  name   = "ticketrail-full-valkey-params"
  family = "valkey8"

  parameter {
    name  = "maxmemory-policy"
    value = "noeviction"
  }

  tags = {
    Name = "ticketrail-full-valkey-params"
  }
}

# =========================================
# ElastiCache Valkey Replication Group
# =========================================
resource "aws_elasticache_replication_group" "valkey" {
  replication_group_id = var.valkey.replication_group_id
  description          = "TicketRail Full AWS Valkey"

  engine         = "valkey"
  engine_version = var.valkey.engine_version
  node_type      = var.valkey.node_type
  port           = 6379

  # Single shard: 1 Primary + 2 Replicas
  cluster_mode                = "disabled"
  num_cache_clusters          = var.valkey.num_cache_clusters
  snapshot_retention_limit    = 0
  preferred_cache_cluster_azs = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c"]

  # High Availability
  multi_az_enabled           = var.valkey.multi_az_enabled
  automatic_failover_enabled = var.valkey.automatic_failover


  # Network
  subnet_group_name = aws_elasticache_subnet_group.valkey.name

  security_group_ids = [
    aws_security_group.data_service["valkey"].id
  ]

  parameter_group_name = aws_elasticache_parameter_group.valkey.name

  # Encryption
  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
  transit_encryption_mode    = "required"

  tags = {
    Name = var.valkey.replication_group_id
  }
}
