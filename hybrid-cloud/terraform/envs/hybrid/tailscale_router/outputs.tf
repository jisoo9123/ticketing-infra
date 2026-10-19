output "router_instance_id" {
  description = "Tailscale Router EC2 instance ID"
  value       = module.tailscale_router.router_instance_id
}

output "router_private_ip" {
  description = "Tailscale Router private IP"
  value       = module.tailscale_router.router_private_ip
}

output "router_network_interface_id" {
  description = "Tailscale Router primary ENI ID"
  value       = module.tailscale_router.router_network_interface_id
}

output "test_instance_id" {
  description = "Private Test EC2 instance ID"
  value       = module.tailscale_router.test_instance_id
}

output "test_private_ip" {
  description = "Private Test EC2 private IP"
  value       = module.tailscale_router.test_private_ip
}

output "onprem_route_ids" {
  description = "On-Prem routes created in private route tables"
  value       = module.tailscale_router.onprem_route_ids
}
