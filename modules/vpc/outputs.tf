output "network_id" {
  description = "ID of the created VPC network."
  value       = google_compute_network.network.id
}

output "network_name" {
  description = "Name of the created VPC network."
  value       = google_compute_network.network.name
}

output "subnet_name" {
  description = "Name of the created subnetwork."
  value       = google_compute_subnetwork.subnetwork.name
}

output "firewall_names" {
  description = "Names of the created firewall rules."
  value       = [for rule in values(google_compute_firewall.firewall) : rule.name]
}
