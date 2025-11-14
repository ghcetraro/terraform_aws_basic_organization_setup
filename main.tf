# Data source to retrieve the Identity Store ID
data "aws_ssoadmin_instances" "id" {}
#
resource "aws_identitystore_group" "groups" {
  for_each          = toset(var.grupos)
  identity_store_id = tolist(data.aws_ssoadmin_instances.id.identity_store_ids)[0]
  display_name      = each.key
  description       = "Grupo para ${each.key}"
}
#
# Create Permission Set
resource "aws_ssoadmin_permission_set" "set" {
  for_each         = toset(var.permission_set)
  name             = each.key
  description      = "Permission Set para ${each.key}"
  instance_arn     = tolist(data.aws_ssoadmin_instances.id.arns)[0]
  session_duration = "PT8H"
}
#
