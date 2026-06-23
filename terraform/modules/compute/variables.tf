variable "project_name" {
  type        = string
  description = "Nome do projeto usado nas tags e nomes dos recursos de compute"
}

variable "admin_username" {
  type        = string
  description = "Usuario administrador da VM"
}

variable "ssh_public_key_path" {
  type        = string
  description = "Caminho para a chave publica SSH"
}

variable "instance_type" {
  type        = string
  description = "Tipo da instancia EC2"
}
