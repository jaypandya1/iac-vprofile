terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      # Changed to ~> 6.0 to match EKS Module v21 requirements
      version = "~> 6.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.0"
    }

    tls = {
      source  = "hashicorp/tls" ##
      version = "~> 4.0.6"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.3.5"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.35.0"
    }
  }

  backend "s3" {
    bucket  = "vprofileactionskube"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }

  required_version = ">= 1.10.0"
}