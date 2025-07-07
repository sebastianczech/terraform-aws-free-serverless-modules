terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.2"
    }

    external = {
      source  = "hashicorp/external"
      version = "~> 2.0"
    }
  }

  required_version = ">= 1.5.0"
}
