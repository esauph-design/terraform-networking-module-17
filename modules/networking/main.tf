resource "azurerm_resource_group" "resource_group" {

  name     = var.resource_group_name
  location = var.location
  tags     = var.tags

}
resource "azurerm_virtual_network" "virtual_network" {

  name                = var.virtual_network_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  address_space       = var.address_space
  tags                = var.tags
}

resource "azurerm_subnet" "subnet" {

  for_each = var.subnets

  name = each.key

  address_prefixes = [
    each.value.address_prefix
  ]
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.virtual_network.name

}
resource "azurerm_network_security_group" "application_nsg" {
  name                = var.network_security_group_name
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
  tags                = var.tags


  dynamic "security_rule" {
    for_each = var.security_rules

    iterator = rule

    content {
      name                       = rule.key
      priority                   = rule.value.priority
      direction                  = rule.value.direction
      access                     = rule.value.access
      protocol                   = rule.value.protocol
      source_port_range          = rule.value.source_port_range
      destination_port_range     = rule.value.destination_port_range
      source_address_prefix      = rule.value.source_address_prefix
      destination_address_prefix = rule.value.destination_address_prefix

    }
  }

}
resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association" {
  for_each = var.subnets

  subnet_id                 = azurerm_subnet.subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.application_nsg.id

}


