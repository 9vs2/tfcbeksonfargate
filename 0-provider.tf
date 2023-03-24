provider "aws" {
    region = var.region
}

variable "cluster_name" {
  default = "jsgu-tfcb-eks-test"
}

variable "cluster_version" {
  default = "1.23"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}