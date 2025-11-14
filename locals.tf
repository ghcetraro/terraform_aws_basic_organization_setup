locals {
  #
  aws_profile = var.account
  #
  tags = {
    project      = var.project
    service_name = var.project
    environment  = var.environment
    created_by   = "terraform"
    region       = var.region
    role         = var.role
  }
}