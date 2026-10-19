terraform {
  required_version = ">= 1.5.7, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.66.0"
    }

    rhcs = {
      source  = "terraform-redhat/rhcs"
      version = "~> 1.7.8"
    }
  }
}
