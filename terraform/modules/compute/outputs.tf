output "ip_publico_vm" {
  description = "IP publico da VM do frontend de prod"
  value       = aws_eip.frontend.public_ip
}

output "ip_privado_frontend" {
  description = "IP privado da VM do frontend de prod"
  value       = aws_instance.frontend.private_ip
}

# homolog desativado - ver modules/compute/main.tf
# output "ip_publico_frontend_homolog" {
#   description = "IP publico da VM do frontend de homolog"
#   value       = aws_eip.frontend_homolog.public_ip
# }
#
# output "ip_privado_frontend_homolog" {
#   description = "IP privado da VM do frontend de homolog"
#   value       = aws_instance.frontend_homolog.private_ip
# }

output "ip_publico_gateway" {
  description = "IP publico da VM do Kong Gateway"
  value       = aws_eip.gateway.public_ip
}
