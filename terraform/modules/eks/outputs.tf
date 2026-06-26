output "cluster_name" {
  description = "Nome do cluster EKS"
  value       = aws_eks_cluster.this.name
}

output "cluster_endpoint" {
  description = "Endpoint da API do cluster EKS"
  value       = aws_eks_cluster.this.endpoint
}

output "vpc_id" {
  description = "ID da VPC do EKS"
  value       = aws_vpc.eks.id
}

output "public_subnet_ids" {
  description = "IDs das subnets publicas do EKS"
  value       = aws_subnet.public[*].id
}

output "prod_node_group_name" {
  description = "Nome do node group de prod"
  value       = aws_eks_node_group.prod.node_group_name
}

# homolog desativado temporariamente.
# output "homolog_node_group_name" {
#   description = "Nome do node group de homolog"
#   value       = aws_eks_node_group.homolog.node_group_name
# }
