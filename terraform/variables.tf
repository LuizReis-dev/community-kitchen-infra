variable "project_name" {
  type        = string
  description = "Nome do projeto usado nas tags e nomes dos recursos"
  default     = "community-kitchen-frontend"
}

variable "aws_region" {
  type        = string
  description = "Regiao da AWS onde os recursos serao criados"
  default     = "us-east-1"
}

variable "admin_username" {
  type        = string
  description = "Usuario administrador da VM"
  default     = "adminuser"
}

variable "ssh_public_key_path" {
  type        = string
  description = "Caminho para a chave publica SSH"
  default     = "~/.ssh/id_rsa.pub"
}

variable "instance_types" {
  type        = list(string)
  description = "Lista de tipos de instancia EC2 disponiveis"
  default = [
    "t3.nano",
    "t3.micro",
    "t3.small",
  ]
}

variable "instance_type_index" {
  type        = number
  description = "Indice da lista instance_types a ser usado"
  default     = 0

  validation {
    condition     = var.instance_type_index >= 0 && var.instance_type_index < length(var.instance_types)
    error_message = "instance_type_index deve apontar para um item existente em instance_types."
  }
}

variable "eks_cluster_name" {
  type        = string
  description = "Nome do cluster EKS"
  default     = "community-kitchen-eks"
}

variable "eks_cluster_version" {
  type        = string
  description = "Versao do Kubernetes no EKS"
  default     = "1.30"
}

variable "eks_vpc_cidr" {
  type        = string
  description = "CIDR da VPC usada pelo EKS"
  default     = "10.20.0.0/16"
}

variable "eks_public_subnet_cidrs" {
  type        = list(string)
  description = "CIDRs das subnets publicas usadas pelo EKS"
  default = [
    "10.20.1.0/24",
    "10.20.2.0/24",
  ]
}

variable "eks_node_instance_types" {
  type        = list(string)
  description = "Tipos de instancia dos node groups do EKS"
  default     = ["t3.small"]
}

variable "eks_prod_node_desired_size" {
  type        = number
  description = "Quantidade desejada de nodes no node group de prod"
  default     = 1
}

variable "eks_prod_node_min_size" {
  type        = number
  description = "Quantidade minima de nodes no node group de prod"
  default     = 1
}

variable "eks_prod_node_max_size" {
  type        = number
  description = "Quantidade maxima de nodes no node group de prod"
  default     = 2
}

# homolog desativado temporariamente.
# variable "eks_homolog_node_desired_size" {
#   type        = number
#   description = "Quantidade desejada de nodes no node group de homolog"
#   default     = 1
# }
#
# variable "eks_homolog_node_min_size" {
#   type        = number
#   description = "Quantidade minima de nodes no node group de homolog"
#   default     = 1
# }
#
# variable "eks_homolog_node_max_size" {
#   type        = number
#   description = "Quantidade maxima de nodes no node group de homolog"
#   default     = 2
# }
