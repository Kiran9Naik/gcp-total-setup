variable "instance_name" {
  description = "List of VM instance names. Use one name for automatic suffixing or one name per instance."
  type        = list(string)

  validation {
    condition     = length(var.instance_name) == 1 || length(var.instance_name) == var.instance_count
    error_message = "instance_name must contain either 1 name or exactly instance_count names."
  }
}
variable "machine_type" {
  description = "Machine type for the VM instance."
  type        = string

}
variable "disk_size" {
  description = "Size of the boot disk in GB (optional, default is 10GB)."
  type        = number
  default     = null

}

variable "instance_count" {
  description = "Number of VM instances to create."
  type        = number
  default     = 1
}

variable "boot_disk_type" {
  description = "Boot disk type."
  type        = string
  default     = "pd-balanced"
}

variable "zone" {
  description = "Zone for the VM instance."
  type        = string
}
variable "image" {
  description = "Boot disk image for the VM instance."
  type        = string
}
variable "network" {
  description = "VPC network for the VM instance."
  type        = string
}
variable "subnetwork" {
  description = "Subnetwork for the VM instance."
  type        = string
}
