variable "network_name" {
  description = "Name of the VPC network."
  type        = string
}

variable "auto_create_subnetworks" {
  description = "Whether to automatically create subnets."
  type        = bool
  default     = false
}

variable "region" {
  description = "Region for the subnet."
  type        = string
}

variable "subnet_name" {
  description = "Name of the subnetwork."
  type        = string
}

variable "subnet_cidr_range" {
  description = "CIDR range for the primary subnet."
  type        = string
}

variable "firewall_rules" {
  description = "List of firewall rules to create for the VPC."
  type = list(object({
    name          = string
    description   = optional(string)
    source_ranges = list(string)
    allow = list(object({
      protocol = string
      ports    = optional(list(string))
    }))
  }))
  default = []
}

