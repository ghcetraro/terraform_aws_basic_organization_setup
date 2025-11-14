#
output "identity_store_ids" {
  value = tolist(data.aws_ssoadmin_instances.id.identity_store_ids)[0]
}
#
output "arns" {
  value = data.aws_ssoadmin_instances.id.arns
}
#
output "groups" {
  value = aws_identitystore_group.groups
}