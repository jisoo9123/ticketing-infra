# =========================================
# Existing Network
# =========================================
output "vpc_id" {
  description = "Existing AWS VPC ID"
  value       = local.vpc_id
}

output "private_subnet_ids" {
  description = "Existing private subnet IDs"
  value       = local.private_subnet_ids
}

# =========================================
# RDS PostgreSQL
# =========================================
output "rds_endpoint" {
  description = "RDS PostgreSQL endpoint"
  value       = aws_db_instance.postgres.endpoint
}

output "rds_identifier" {
  description = "RDS PostgreSQL identifier"
  value       = aws_db_instance.postgres.identifier
}

# =========================================
# Amazon MSK
# =========================================
output "msk_cluster_arn" {
  description = "Amazon MSK cluster ARN"
  value       = aws_msk_cluster.ticketrail.arn
}

output "msk_bootstrap_brokers_iam" {
  description = "MSK IAM authentication bootstrap brokers"
  value       = aws_msk_cluster.ticketrail.bootstrap_brokers_sasl_iam
}

# =========================================
# ElastiCache Valkey
# =========================================
output "valkey_primary_endpoint" {
  description = "Valkey primary endpoint"
  value       = aws_elasticache_replication_group.valkey.primary_endpoint_address
}

output "valkey_reader_endpoint" {
  description = "Valkey reader endpoint"
  value       = aws_elasticache_replication_group.valkey.reader_endpoint_address
}
