# Terraform Networking Module (Module 17)

This project demonstrates how to build a reusable Azure networking module using Terraform.

## Resources Created

- Resource Group
- Virtual Network
- Three Subnets
  - session_hosts
  - management
  - private_endpoints
- Network Security Group (NSG)
- Dynamic NSG Security Rules
- Subnet-to-NSG Associations

## Concepts Covered

- Terraform Modules
- for_each
- Dynamic Blocks
- map(object(...))
- Module Inputs and Outputs
- Azure Networking Fundamentals
- Resource Associations
- Implicit Dependencies
- Reusable Infrastructure Design

## Subnet Configuration

```hcl
subnets = {
  session_hosts = {
    address_prefix = "10.0.1.0/24"
  }

  management = {
    address_prefix = "10.0.2.0/24"
  }

  private_endpoints = {
    address_prefix = "10.0.3.0/24"
  }
}
```

## Security Rules

Security rules are defined as a map of objects and created dynamically using a Terraform dynamic block.

Example:

```hcl
security_rules = {
  HTTPS = {
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
```

## Outputs

The module exposes subnet IDs as a map:

```hcl
output "subnet_ids"
```

Example usage:

```hcl
module.networking.subnet_ids["session_hosts"]
```

## Architecture

```
Resource Group
│
├── Virtual Network
│
├── Subnets
│   ├── session_hosts
│   ├── management
│   └── private_endpoints
│
├── Network Security Group
│
└── Subnet NSG Associations
```

This module is designed to be reused in future Azure infrastructure deployments.