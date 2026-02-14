variable "name" {
  type        = string
  description = "Base name for resources"
}

variable "environment" {
  type        = string
  description = "Environment name"
  validation {
    condition     = contains(["prod"], var.environment)
    error_message = "environment must be prod"
  }
}

variable "region" {
  type        = string
  description = "DigitalOcean region"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR for VPC"
}

variable "ssh_key" {
  type        = string
  description = "DigitalOcean SSH key fingerprint/id for droplet access"
  validation {
    condition     = length(trimspace(var.ssh_key)) > 0
    error_message = "ssh_key is required"
  }
}

variable "droplet_size" {
  type        = string
  description = "Droplet size"
}

variable "droplet_image" {
  type        = string
  description = "Droplet image slug"
}

variable "enable_ipv6" {
  type        = bool
  description = "Enable IPv6 on droplet"
  default     = false
}
