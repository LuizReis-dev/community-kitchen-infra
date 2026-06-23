output "ip_publico_vm" {
  description = "IP publico da VM"
  value       = aws_eip.ip.public_ip
}
