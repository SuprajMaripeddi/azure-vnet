resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
  count = (var.create_network_security_group ? 1 : 0)

  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.0.id
}

resource "azurerm_network_security_group" "nsg" {
  count = (var.create_network_security_group ? 1 : 0)

  name                = var.security_group_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_rule" "deny_all_inbound" {
  count                       = ((var.create_network_security_group && var.configure_nsg_rules) ? 1 : 0)

  name                        = "AllowAllInbound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.0.name
}

variable "create_network_security_group" {
  description = "Create/associate network security group"
  type        = bool
  default     = true
}

variable "configure_nsg_rules" {
  description = "Configure network security group rules"
  type        = bool
  default     = false
}
variable "security_group_name" {
  description = "security group name"
  type        = string
}
