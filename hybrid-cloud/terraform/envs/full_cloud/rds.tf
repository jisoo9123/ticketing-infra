# =========================================
# RDS PostgreSQL Subnet Group
# =========================================
resource "aws_db_subnet_group" "postgres" {
  name       = "ticketrail-full-postgres-subnets"
  subnet_ids = local.private_subnet_ids

  tags = {
    Name = "ticketrail-full-postgres-subnets"
  }
}

# =========================================
# RDS PostgreSQL Instance
# =========================================
resource "aws_db_instance" "postgres" {
  identifier     = var.rds.identifier
  engine         = "postgres"
  engine_version = var.rds.engine_version
  instance_class = var.rds.instance_class

  # Storage
  allocated_storage = var.rds.allocated_storage
  storage_type      = var.rds.storage_type
  storage_encrypted = true

  # High Availability
  multi_az                = var.rds.multi_az
  backup_retention_period = var.rds.backup_retention

  # Network
  db_subnet_group_name = aws_db_subnet_group.postgres.name

  vpc_security_group_ids = [
    aws_security_group.data_service["rds"].id
  ]

  publicly_accessible = false
  port                = 5432

  # Authentication
  username                    = "ticketrailadmin"
  manage_master_user_password = true

  # Operational Safety
  deletion_protection      = false
  skip_final_snapshot      = true
  delete_automated_backups = true

  tags = {
    Name = var.rds.identifier
  }
}
