# RDS PostgreSQL
variable "rds" {
  description = "RDS PostgreSQL configuration"
  type = object({
    identifier        = string
    engine_version    = string
    instance_class    = string
    storage_type      = string
    allocated_storage = number
    multi_az          = bool
    backup_retention  = number
  })
}

# Amazon MSK Kafka
variable "msk" {
  description = "Amazon MSK configuration"
  type = object({
    cluster_name        = string
    kafka_version       = string
    instance_type       = string
    broker_count        = number
    ebs_volume_size     = number
    retention_hours     = number
    min_insync_replicas = number
  })
}

# ElastiCache Valkey
variable "valkey" {
  description = "ElastiCache Valkey configuration"
  type = object({
    replication_group_id = string
    engine_version       = string
    node_type            = string
    num_cache_clusters   = number
    multi_az_enabled     = bool
    automatic_failover   = bool
  })
}
variable "rosa_worker_sg_id" {
  description = "Existing ROSA Worker Security Group ID"
  type        = string
}
