variable "region" {
  description = "Primary region for the VPC resources."
  type        = string
  default     = "asia-south1"
}

variable "network_name" {
  description = "Name of the VPC network."
  type        = string
  default     = "vault-vpc-network"
}

variable "auto_create_subnetworks" {
  description = "Whether to automatically create subnets."
  type        = bool
  default     = false
}

variable "subnet_name" {
  description = "Name of the subnetwork."
  type        = string
  default     = "vault-subnet"
}

variable "subnet_cidr_range" {
  description = "CIDR range for the primary subnet."
  type        = string
  default     = "10.2.0.0/30"
}

variable "firewall_rules" {
  description = "Firewall rules to create for the VPC."
  type = list(object({
    name          = string
    description   = optional(string)
    source_ranges = list(string)
    allow = list(object({
      protocol = string
      ports    = optional(list(string))
    }))
  }))
  default = [
    {
      name          = "allow-vault"
      description   = "Allow Vault access"
      source_ranges = ["10.2.0.0/30"]
      allow = [
        {
          protocol = "tcp"
          ports    = ["22", "8200", "8201"]
        }
      ]
    }
  ]
}
