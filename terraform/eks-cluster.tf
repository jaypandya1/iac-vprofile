module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.16.0"

  # 🚨 V21 RENAMED VARIABLES
  name                   = var.clusterName
  kubernetes_version     = "1.34"
  endpoint_public_access = true

  # 🚨 NEW IN V21: CRITICAL FOR GITHUB ACTIONS
  # This replaces the old aws-auth configmap. It ensures the IAM role running 
  # your pipeline actually has permissions to run kubectl commands later.
  enable_cluster_creator_admin_permissions = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # 🚨 V21 REFACTOR: eks_managed_node_group_defaults was changed.
  # Simply move the ami_type directly into your node group block.
  eks_managed_node_groups = {
    one = {
      name           = "node-group-1"
      instance_types = ["t3.small"]
      min_size       = 1
      max_size       = 3
      desired_size   = 2
      ami_type       = "AL2023_x86_64_STANDARD" # Moved here
    }
  }
}