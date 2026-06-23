terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.99.0"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

module "compute" {
  source = "./modules/compute"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  admin_username      = var.admin_username
  ssh_public_key_path = var.ssh_public_key_path
  vm_size             = var.vm_sizes[var.vm_size_index]
}

output "ip_publico_vm" {
  description = "IP publico da VM"
  value       = module.compute.ip_publico_vm
}
