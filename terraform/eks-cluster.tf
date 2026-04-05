module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.16.0"

  # Directly referencing the variable you defined
  cluster_name    = var.clusterName
  cluster_version = "1.34"

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  cluster_endpoint_public_access = true

  # FIX: correct variable name (plural "groups")
  eks_managed_node_group_defaults = {
    ami_type = "AL2023_x86_64_STANDARD"
  }

  eks_managed_node_groups = {
    one = {
      name           = "node-group-1"
      instance_types = ["t3.small"]
      min_size       = 1
      max_size       = 3
      desired_size   = 2
    }
  }
}