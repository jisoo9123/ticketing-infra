# =========================================
# Amazon MSK Kafka Configuration
# =========================================
resource "aws_msk_configuration" "ticketrail" {
  name           = "ticketrail-full-msk-config"
  description    = "TicketRail Full AWS Kafka configuration"
  kafka_versions = [var.msk.kafka_version]

  server_properties = <<-PROPERTIES
log.retention.hours=${var.msk.retention_hours}
min.insync.replicas=${var.msk.min_insync_replicas}
PROPERTIES
}

# =========================================
# Amazon MSK Provisioned Cluster
# =========================================
resource "aws_msk_cluster" "ticketrail" {
  cluster_name           = var.msk.cluster_name
  kafka_version          = var.msk.kafka_version
  number_of_broker_nodes = var.msk.broker_count

  # Broker Configuration
  broker_node_group_info {
    instance_type  = var.msk.instance_type
    client_subnets = local.private_subnet_ids

    security_groups = [
      aws_security_group.data_service["msk"].id
    ]

    storage_info {
      ebs_storage_info {
        volume_size = var.msk.ebs_volume_size
      }
    }

    connectivity_info {
      public_access {
        type = "DISABLED"
      }
    }
  }

  # Kafka Configuration
  configuration_info {
    arn      = aws_msk_configuration.ticketrail.arn
    revision = aws_msk_configuration.ticketrail.latest_revision
  }

  # Client Authentication
  client_authentication {
    sasl {
      iam = true
    }
  }

  # Encryption
  encryption_info {
    encryption_in_transit {
      client_broker = "TLS"
      in_cluster    = true
    }
  }

  enhanced_monitoring = "DEFAULT"

  tags = {
    Name = var.msk.cluster_name
  }
}
