resource "google_compute_network" "network" {
  name                    = var.network_name
  auto_create_subnetworks = var.auto_create_subnetworks
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr_range
  region        = var.region
  network       = google_compute_network.network.id
}

resource "google_compute_firewall" "firewall" {
  for_each = { for rule in var.firewall_rules : rule.name => rule }

  name          = each.value.name
  network       = google_compute_network.network.id
  description   = coalesce(each.value.description, "Firewall rule ${each.value.name}")
  source_ranges = each.value.source_ranges

  dynamic "allow" {
    for_each = each.value.allow
    content {
      protocol = allow.value.protocol
      ports    = try(allow.value.ports, null)
    }
  }
}
