output "vpc_network_id" {
  description = "ID of the created VPC network."
  value       = module.vpc.network_id
}

output "vpc_network_name" {
  description = "Name of the created VPC network."
  value       = module.vpc.network_name
}

output "vpc_subnet_name" {
  description = "Name of the created subnetwork."
  value       = module.vpc.subnet_name
}

output "vpc_firewall_names" {
  description = "Firewall rule names created for the VPC."
  value       = module.vpc.firewall_names
}

output "instance_id" {
  description = "ID of the created EC2 instance."
  value       = module.ec2[*].instance_id
}
