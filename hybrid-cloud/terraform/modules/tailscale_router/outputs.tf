output "router_instance_id" {
  description = "Tailscale Router EC2 instance ID"
  value       = aws_instance.router.id
}

output "router_private_ip" {
  description = "Tailscale Router private IP"
  value       = aws_instance.router.private_ip
}

output "router_network_interface_id" {
  description = "Tailscale Router primary ENI ID"
  value       = aws_instance.router.primary_network_interface_id
}

output "test_instance_id" {
  description = "Private Test EC2 instance ID"
  value       = aws_instance.test.id
}

output "test_private_ip" {
  description = "Private Test EC2 private IP"
  value       = aws_instance.test.private_ip
}

output "onprem_route_ids" {
  description = "On-Prem routes created in private route tables"
  value       = aws_route.onprem[*].id
}
