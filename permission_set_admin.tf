#
data "aws_ssoadmin_permission_set" "admin" {
  instance_arn = tolist(data.aws_ssoadmin_instances.id.arns)[0]
  name         = "admin" # Name of the existing Permission Set
}
#
data "aws_identitystore_group" "admin" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.id.identity_store_ids)[0]

  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = "admin"
    }
  }
}
#
resource "aws_ssoadmin_managed_policy_attachment" "admin" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.id.arns)[0]
  permission_set_arn = data.aws_ssoadmin_permission_set.admin.arn
  managed_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
#
resource "aws_ssoadmin_account_assignment" "admin_pepe_development" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.id.arns)[0]
  permission_set_arn = data.aws_ssoadmin_permission_set.admin.arn
  principal_id       = data.aws_identitystore_group.admin.group_id
  principal_type     = "GROUP"
  target_id          = var.list_of_accounts_ids.development
  target_type        = "AWS_ACCOUNT"
}
#
resource "aws_ssoadmin_account_assignment" "admin_pepe_staging" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.id.arns)[0]
  permission_set_arn = data.aws_ssoadmin_permission_set.admin.arn
  principal_id       = data.aws_identitystore_group.admin.group_id
  principal_type     = "GROUP"
  target_id          = var.list_of_accounts_ids.staging
  target_type        = "AWS_ACCOUNT"
}
#
resource "aws_ssoadmin_account_assignment" "admin_pepe_production" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.id.arns)[0]
  permission_set_arn = data.aws_ssoadmin_permission_set.admin.arn
  principal_id       = data.aws_identitystore_group.admin.group_id
  principal_type     = "GROUP"
  target_id          = var.list_of_accounts_ids.production
  target_type        = "AWS_ACCOUNT"
}
