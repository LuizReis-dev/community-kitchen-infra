variable "project_name" {
  type        = string
  description = "Nome do projeto usado nas tags e nomes dos recursos do EKS"
}

variable "cluster_name" {
  type        = string
  description = "Nome do cluster EKS"
}

variable "cluster_version" {
  type        = string
  description = "Versao do Kubernetes no EKS"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR da VPC do EKS"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "CIDRs das subnets publicas do EKS"
}

variable "node_instance_types" {
  type        = list(string)
  description = "Tipos de instancia usados pelos node groups"
}

variable "prod_node_desired_size" {
  type        = number
  description = "Quantidade desejada de nodes de prod"
}

variable "prod_node_min_size" {
  type        = number
  description = "Quantidade minima de nodes de prod"
}

variable "prod_node_max_size" {
  type        = number
  description = "Quantidade maxima de nodes de prod"
}

# homolog desativado - ver modules/eks/main.tf
# variable "homolog_node_desired_size" {
#   type        = number
#   description = "Quantidade desejada de nodes de homolog"
# }
#
# variable "homolog_node_min_size" {
#   type        = number
#   description = "Quantidade minima de nodes de homolog"
# }
#
# variable "homolog_node_max_size" {
#   type        = number
#   description = "Quantidade maxima de nodes de homolog"
# }
