variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "tags" {
  type = map(string)
}
variable "virtual_network_name" {
  type = string
}
variable "address_space" {
  type = list(string)
}
variable "network_security_group_name" {
  type = string
}
variable "subnets" {
  type = map(object(
    {
      address_prefix = string
    }
    )
  )
}
variable "security_rules" {
  type = map(object({
    priority                   = number
    protocol                   = string
    access                     = string
    direction                  = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}