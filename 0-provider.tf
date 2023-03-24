provider "aws" {
    region = "ap-northeast-3"
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