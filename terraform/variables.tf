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
