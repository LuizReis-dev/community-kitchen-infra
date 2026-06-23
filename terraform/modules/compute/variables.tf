variable "resource_group_name" {
  type        = string
  description = "Nome do resource group onde os recursos de compute serao criados"
}

variable "location" {
  type        = string
  description = "Regiao do Azure onde os recursos de compute serao criados"
}

variable "admin_username" {
  type        = string
  description = "Usuario administrador da VM"
}

variable "ssh_public_key_path" {
  type        = string
  description = "Caminho para a chave publica SSH"
}

variable "vm_size" {
  type        = string
  description = "Tamanho da VM"
}
