variable "rg_name" {
  description = "Name of Resource Group"
  type = string
}

variable "rg_location" {
  description = "Resource Group Location"
  type = string
}

variable "virtual_network_name" {
  description = "Name of Virtual Network"
  type = string
}

variable "subnet_name" {
  description = "Name of Subnet"
  type = string
}

variable "public_ip_name" {
  description = "Name of Public IP"
  type = string
}

variable "domain_label_name" {
  description = "Name of Domain Name Label"
  type = string
}

variable "environment" {
  description = "Environment Name"
  type = map(string)
  default =  {
    dev1 = "Development"
    prod1 = "Production"
    stag1 = "Staging"
  }
}

variable "network_interface_name" {
  description = "Name of Network Interface"
  type = string
}

variable "vm_name" {
  description = "Name of Linux Virtual Machine"
  type = string
}

variable "computer_name" {
  description = "Computer Name for Linux Virtual Machine"
  type = string
}

variable "ssh_username" {
  description = "Username for Admin SSH Key"
  type = string
}

variable "os_disk_name" {
  description = "Name of OS Disk"
  type = string
}