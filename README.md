# gcp-total-setup

A Terraform repository for provisioning a Google Cloud Platform environment that includes a VPC, subnetwork, firewall rules, and VM instances.

## Repository structure

- `provider.tf` - Root Google provider configuration.
- `versions.tf` - Terraform version and provider requirements.
- `environment/vault/` - Example deployment environment for Vault-like infrastructure.
  - `main.tf` - Instantiates `vpc` and `ec2` modules.
  - `provider.tf` - Google provider configuration for the environment.
  - `variables.tf` - Default input values for the environment.
  - `terraform.tfvars` - Example variables values.
  - `outputs.tf` - Exposes environment outputs.
- `modules/vpc/` - VPC module for network, subnetwork, and firewall.
- `modules/ec2/` - Compute module for creating Google Compute Engine instances.

## What this repo provisions

- Google Cloud VPC network
- Subnetwork within the selected region
- Firewall rules for SSH and Vault ports
- One or more Compute Engine VM instances attached to the VPC/subnet

## Modules

### `modules/vpc`

Creates:
- `google_compute_network`
- `google_compute_subnetwork`
- `google_compute_firewall` (one or more rules)

Inputs include:
- `network_name`
- `auto_create_subnetworks`
- `region`
- `subnet_name`
- `subnet_cidr_range`
- `firewall_rules`

Outputs include:
- `network_id`
- `network_name`
- `subnet_name`
- `firewall_names`

### `modules/ec2`

Creates one or more Google Compute Engine instances using:
- `instance_count`
- `instance_name`
- `machine_type`
- `zone`
- `network`
- `subnetwork`
- `image`
- `disk_size`
- `boot_disk_type`

## Example environment: `environment/vault`

This environment uses the `vpc` and `ec2` modules to create:
- A Vault-style VPC and subnet
- Firewall access for ports `22`, `8200`, and `8201`
- Two Ubuntu 22.04 VM instances by default

### Default environment values

The environment defaults include:
- `region = "asia-south1"`
- `network_name = "vault-vpc-network"`
- `subnet_name = "vault-subnet"`
- `subnet_cidr_range = "10.2.0.0/30"`
- Firewall rule allowing `tcp` ports `22`, `8200`, and `8201`

## Usage

1. Install Terraform and authenticate to GCP.
2. Change to the environment directory:
   ```bash
   cd environment/vault
   ```
3. Initialize Terraform:
   ```bash
   terraform init
   ```
4. Review the planned changes:
   ```bash
   terraform plan
   ```
5. Apply the infrastructure:
   ```bash
   terraform apply
   ```
6. When finished, destroy resources:
   ```bash
   terraform destroy
   ```

## Notes

- Update the Google project ID in `environment/vault/provider.tf` or `provider.tf` before applying if you are using a different project.
- The `ec2` module is intended for GCP Compute Engine instances, not AWS EC2.
- Adjust the firewall rules and instance configuration as needed for your environment.

