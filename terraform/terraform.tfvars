project_name        = "community-kitchen-frontend"
aws_region          = "us-east-1"
admin_username      = "adminuser"
ssh_public_key_path = "~/.ssh/id_rsa.pub"
instance_type_index = 2

eks_cluster_name              = "community-kitchen-eks"
eks_cluster_version           = "1.30"
eks_vpc_cidr                  = "10.20.0.0/16"
eks_public_subnet_cidrs       = ["10.20.1.0/24", "10.20.2.0/24"]
eks_node_instance_types       = ["t3.medium"]
eks_prod_node_desired_size    = 2
eks_prod_node_min_size        = 2
eks_prod_node_max_size        = 2
eks_homolog_node_desired_size = 1
eks_homolog_node_min_size     = 1
eks_homolog_node_max_size     = 1
