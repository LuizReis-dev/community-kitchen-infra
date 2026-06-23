output "ip_publico_vm" {
  description = "IP publico da VM"
  value       = azurerm_public_ip.ip.ip_address
}
