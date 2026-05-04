resource "google_compute_instance" "ec2_instance" {
  count        = var.instance_count
  name         = length(var.instance_name) == 1 && var.instance_count > 1 ? "${var.instance_name[0]}-${count.index + 1}" : var.instance_name[count.index]
  machine_type = var.machine_type
  zone         = var.zone
  

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.disk_size != null ? var.disk_size : 10
      type  = var.boot_disk_type
    }


  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    access_config {}
  }

}