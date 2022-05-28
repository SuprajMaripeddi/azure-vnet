resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  tags                = var.tags
  dns_servers         = var.dns_servers
}

variable "vnet_name" {
  description = "network name"
  type        = string
}
variable "dns_servers" {
  description = "If applicable, a list of custom DNS servers to use inside your virtual network.  Unset will use default Azure-provided resolver"
  type        = list(string)
  default     = null
}
variable "address_space" {
  description = "CIDRs for virtual network"
  type        = list(string)
}
variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}
variable "location" {
  description = "Azure Region"
  type        = string
}
variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
}
