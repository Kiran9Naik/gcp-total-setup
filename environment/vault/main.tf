module "vpc" {
  source                  = "../../modules/vpc"
  network_name            = var.network_name
  auto_create_subnetworks = var.auto_create_subnetworks
  region                  = var.region
  subnet_name             = var.subnet_name
  subnet_cidr_range       = var.subnet_cidr_range
  firewall_rules          = var.firewall_rules
}
module "ec2" {
  source         = "../../modules/ec2"
  instance_count = 2
  instance_name  = ["vault-instance-1", "vault-instance-2"]
  machine_type   = "e2-medium"
  zone           = "${var.region}-a"
  network        = module.vpc.network_name
  subnetwork     = module.vpc.subnet_name
  image          = "projects/ubuntu-os-cloud/global/images/family/ubuntu-2204-lts"
  disk_size      = 50
  
}
