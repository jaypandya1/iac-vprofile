module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.16.0" # Latest version in April 2026

  cluster_name    = local.cluster_name
  cluster_version = "1.34" # Modern stable version

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  cluster_endpoint_public_access = true

  # New in v20/v21: Automatically grants the creator (you/Terraform) admin rights
  enable_cluster_creator_admin_permissions = true

  eks_managed_node_group_defaults = {
    # Updated to the modern Amazon Linux 2023
    ami_type = "AL2023_x86_64_STANDARD"
  }

  eks_managed_node_groups = {
    one = {
      name = "node-group-1"
      instance_types = ["t3.small"]

      min_size     = 1
      max_size     = 3
      desired_size = 2
    }

    two = {
      name = "node-group-2"
      instance_types = ["t3.small"]

      min_size     = 1
      max_size     = 2
      desired_size = 1
    }
  }
}