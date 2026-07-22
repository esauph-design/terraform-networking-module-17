module "networking" {
  source                      = "./modules/networking"
  resource_group_name         = var.resource_group_name
  location                    = var.location
  tags                        = var.tags
  virtual_network_name        = var.virtual_network_name
  address_space               = var.address_space
  network_security_group_name = var.network_security_group_name
  subnets                     = var.subnets
  security_rules              = var.security_rules
}

