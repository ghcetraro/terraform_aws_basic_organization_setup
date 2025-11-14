resource "aws_identitystore_user" "user" {
  for_each = var.users
  #
  identity_store_id = tolist(data.aws_ssoadmin_instances.id.identity_store_ids)[0]
  user_name         = each.key
  display_name      = "${lookup(each.value, "name", null)} ${lookup(each.value, "lastname", null)}"
  name {
    given_name  = lookup(each.value, "name", null)
    family_name = lookup(each.value, "lastname", null)
  }
  emails {
    value   = lookup(each.value, "email", null)
    primary = true
    type    = "work"
  }
}