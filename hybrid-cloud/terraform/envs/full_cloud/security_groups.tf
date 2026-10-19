# Full AWS data service ports
locals {
  data_service_ports = {
    rds    = 5432
    msk    = 9098
    valkey = 6379
  }
}

# Separate security group for each managed service
resource "aws_security_group" "data_service" {
  for_each = local.data_service_ports

  name        = "ticketrail-full-${each.key}-sg"
  description = "Security group for TicketRail Full AWS ${each.key}"
  vpc_id      = local.vpc_id

  tags = {
    Name = "ticketrail-full-${each.key}-sg"
  }
}

# Allow application traffic from existing ROSA workers
resource "aws_vpc_security_group_ingress_rule" "from_rosa" {
  for_each = local.data_service_ports

  security_group_id            = aws_security_group.data_service[each.key].id
  referenced_security_group_id = var.rosa_worker_sg_id

  ip_protocol = "tcp"
  from_port   = each.value
  to_port     = each.value

  description = "Allow ${each.key} access from ROSA workers"
}

# Allow communication among MSK brokers
resource "aws_vpc_security_group_ingress_rule" "msk_internal" {
  security_group_id            = aws_security_group.data_service["msk"].id
  referenced_security_group_id = aws_security_group.data_service["msk"].id

  ip_protocol = "-1"

  description = "Allow internal MSK broker communication"
}

# Outbound access (initial design; review before deployment)
resource "aws_vpc_security_group_egress_rule" "outbound" {
  for_each = local.data_service_ports

  security_group_id = aws_security_group.data_service[each.key].id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

  description = "Outbound access for managed data service"
}
