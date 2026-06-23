output "ip_publico_vm" {
  description = "IP publico da VM do frontend"
  value       = aws_eip.frontend.public_ip
}

output "ip_privado_frontend" {
  description = "IP privado da VM do frontend"
  value       = aws_instance.frontend.private_ip
}

output "ip_publico_gateway" {
  description = "IP publico da VM do Kong Gateway"
  value       = aws_eip.gateway.public_ip
}
