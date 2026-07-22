output "resource_group_name" {
  value = azurerm_resource_group.resource_group.name
}
output "virtual_network_name" {
  value = azurerm_virtual_network.virtual_network.name
}
output "virtual_network_id" {
  value = azurerm_virtual_network.virtual_network.id
}
output "subnet_ids" {
  value = {
    for name, subnet in azurerm_subnet.subnet :
    name => subnet.id
  }
}
output "network_security_group_name" {
  value =azurerm_network_security_group.application_nsg.name
}
output "network_security_group_id" {
  value = azurerm_network_security_group.application_nsg.id
}