terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project = var.project_name
    }
  }
}

module "compute" {
  source = "./modules/compute"

  project_name        = var.project_name
  admin_username      = var.admin_username
  ssh_public_key_path = var.ssh_public_key_path
  instance_type       = var.instance_types[var.instance_type_index]
}

output "ip_publico_vm" {
  description = "IP publico da VM"
  value       = module.compute.ip_publico_vm
}
