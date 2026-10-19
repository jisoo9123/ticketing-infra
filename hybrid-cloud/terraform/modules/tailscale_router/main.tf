# =========================================================
# 1. Amazon Linux 2023 AMI
# =========================================================

data "aws_ssm_parameter" "al2023_ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}


# =========================================================
# 2. SSM IAM Role / Instance Profile
# =========================================================

resource "aws_iam_role" "ssm" {
  name = "ticketrail-hybrid-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ssm" {
  name = "ticketrail-hybrid-ssm-profile"
  role = aws_iam_role.ssm.name
}


# =========================================================
# 3. Tailscale Router Security Group
# =========================================================

resource "aws_security_group" "router" {
  name        = "ticketrail-tailscale-router-sg"
  description = "Security group for Ticket Rail Tailscale Router"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.private_subnet_cidrs
  }

  ingress {
    description = "PostgreSQL"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.private_subnet_cidrs
  }

  ingress {
    description = "PostgreSQL NodePort - Hybrid validation"
    from_port   = 31666
    to_port     = 31666
    protocol    = "tcp"
    cidr_blocks = var.private_subnet_cidrs
  }

  ingress {
    description = "Kafka"
    from_port   = 32089
    to_port     = 32092
    protocol    = "tcp"
    cidr_blocks = var.private_subnet_cidrs
  }

  ingress {
    description = "ICMP validation"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = var.private_subnet_cidrs
  }

  egress {
    description = "Validation phase outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ticketrail-tailscale-router-sg"
  }
}


# =========================================================
# 4. Private Test EC2 Security Group
# =========================================================

resource "aws_security_group" "test" {
  name        = "ticketrail-private-test-sg"
  description = "Security group for Ticket Rail Private Test EC2"
  vpc_id      = var.vpc_id

  egress {
    description = "Validation phase outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ticketrail-private-test-sg"
  }
}


# =========================================================
# 5. Tailscale Router EC2
# =========================================================

resource "aws_instance" "router" {
  ami           = data.aws_ssm_parameter.al2023_ami.value
  instance_type = "t3.small"

  subnet_id                   = var.private_subnet_ids[0]
  private_ip                  = var.router_private_ip
  associate_public_ip_address = false

  # Router 역할을 수행해야 하므로 비활성화
  source_dest_check = false

  vpc_security_group_ids = [
    aws_security_group.router.id
  ]

  iam_instance_profile = aws_iam_instance_profile.ssm.name

  user_data = templatefile(
    "${path.module}/router-user-data.sh.tftpl",
    {
      advertised_route = var.aws_advertised_route
    }
  )

  tags = {
    Name = "ticketrail-tailscale-router"
  }
}


# =========================================================
# 6. Private Test EC2
# =========================================================

resource "aws_instance" "test" {
  ami           = data.aws_ssm_parameter.al2023_ami.value
  instance_type = "t3.micro"

  subnet_id                   = var.private_subnet_ids[1]
  associate_public_ip_address = false

  vpc_security_group_ids = [
    aws_security_group.test.id
  ]

  iam_instance_profile = aws_iam_instance_profile.ssm.name

  user_data = file("${path.module}/test-user-data.sh")

  tags = {
    Name = "ticketrail-private-test"
  }
}


# =========================================================
# 7. Private Route Table A/B/C -> Tailscale Router ENI
# =========================================================

resource "aws_route" "onprem" {
  count = length(var.private_route_table_ids)

  route_table_id         = var.private_route_table_ids[count.index]
  destination_cidr_block = var.onprem_cidr

  network_interface_id = aws_instance.router.primary_network_interface_id
}
