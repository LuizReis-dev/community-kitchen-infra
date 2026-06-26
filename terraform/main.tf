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

module "eks" {
  source = "./modules/eks"

  project_name              = var.project_name
  cluster_name              = var.eks_cluster_name
  cluster_version           = var.eks_cluster_version
  vpc_cidr                  = var.eks_vpc_cidr
  public_subnet_cidrs       = var.eks_public_subnet_cidrs
  node_instance_types       = var.eks_node_instance_types
  prod_node_desired_size    = var.eks_prod_node_desired_size
  prod_node_min_size        = var.eks_prod_node_min_size
  prod_node_max_size        = var.eks_prod_node_max_size
  homolog_node_desired_size = var.eks_homolog_node_desired_size
  homolog_node_min_size     = var.eks_homolog_node_min_size
  homolog_node_max_size     = var.eks_homolog_node_max_size
}

output "ip_publico_vm" {
  description = "IP publico da VM"
  value       = module.compute.ip_publico_vm
}

output "ip_privado_frontend" {
  description = "IP privado da VM do frontend"
  value       = module.compute.ip_privado_frontend
}

output "ip_publico_frontend_homolog" {
  description = "IP publico da VM do frontend de homolog"
  value       = module.compute.ip_publico_frontend_homolog
}

output "ip_privado_frontend_homolog" {
  description = "IP privado da VM do frontend de homolog"
  value       = module.compute.ip_privado_frontend_homolog
}

output "ip_publico_gateway" {
  description = "IP publico da VM do Kong Gateway"
  value       = module.compute.ip_publico_gateway
}

output "eks_cluster_name" {
  description = "Nome do cluster EKS"
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "Endpoint da API do cluster EKS"
  value       = module.eks.cluster_endpoint
}

output "eks_vpc_id" {
  description = "ID da VPC do EKS"
  value       = module.eks.vpc_id
}

output "eks_public_subnet_ids" {
  description = "IDs das subnets publicas do EKS"
  value       = module.eks.public_subnet_ids
}

output "eks_prod_node_group_name" {
  description = "Nome do node group de prod do EKS"
  value       = module.eks.prod_node_group_name
}

output "eks_homolog_node_group_name" {
  description = "Nome do node group de homolog do EKS"
  value       = module.eks.homolog_node_group_name
}
