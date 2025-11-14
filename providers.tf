#
terraform {
  required_version = "= 1.4.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.84.0"
    }
  }
}
#
provider "aws" {
  region  = var.region
  profile = local.aws_profile
  default_tags {
    tags = local.tags
  }
}