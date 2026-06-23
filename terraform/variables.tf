variable "resource_group_name" {
  type        = string
  description = "Nome do resource group"
  default     = "rg-frontend"
}

variable "location" {
  type        = string
  description = "Regiao do Azure onde os recursos serao criados"
  default     = "centralus"
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

variable "vm_sizes" {
  type        = list(string)
  description = "Lista de tamanhos de VM disponiveis"
  default = [
    "Standard_D2s_v3",
    "Standard_D2s_v3",
    "Standard_D2as_v4",
  ]
}

variable "vm_size_index" {
  type        = number
  description = "Indice da lista vm_sizes a ser usado"
  default     = 0

  validation {
    condition     = var.vm_size_index >= 0 && var.vm_size_index < length(var.vm_sizes)
    error_message = "vm_size_index deve apontar para um item existente em vm_sizes."
  }
}
