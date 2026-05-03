data "google_project" "project" {
}

resource "google_network_management_vpc_flow_logs_config" "subnet-test" {
  vpc_flow_logs_config_id = "k8s-subnet-test-id"
  location                = "global"
  subnet                  = "projects/${data.google_project.project.number}/regions/asia-south1/subnetworks/${google_compute_subnetwork.subnetwork.name}"
}

resource "google_compute_network" "network" {
  name                    = "k8s-subnet-test-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = "k8s-subnet-test-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = "asia-south1"
  network       = google_compute_network.network.id
  secondary_ip_range {
    range_name    = "k8s-secondary-range"
    ip_cidr_range = "10.3.0.0/16"
  }
  secondary_ip_range {
    range_name    = "k8s-secondary-range-2"
    ip_cidr_range = "10.4.0.0/16"
  }
}

resource "google_compute_firewall" "firewall" {
  name        = "allow-internal-k8s"
  network     = google_compute_network.network.name
  description = "k8s-firwall-creation"

  allow {
    protocol = "all"
  }
  source_ranges = ["10.2.0.0/16", "10.3.0.0/16", "10.4.0.0/16"]
}
resource "google_compute_firewall" "allow_ssh" {
  name        = "allow-ssh-k8s"
  network     = google_compute_network.network.name
  description = "k8s-firwall-creation"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["10.2.0.0/16", "10.3.0.0/16", "10.4.0.0/16"]
  
}
resource "google_compute_firewall" "allow_health_check" {
  name        = "allow-health-check-k8s"
  network     = google_compute_network.network.name
  description = "k8s-firwall-creation"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["10.2.0.0/16", "10.3.0.0/16", "10.4.0.0/16"]
  
}
resource "google_compute_firewall" "allow_external" {
  name        = "allow-external-k8s"
  network     = google_compute_network.network.name
  description = "k8s-firwall-creation"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  
}
