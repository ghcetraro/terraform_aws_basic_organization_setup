#
data "aws_identitystore_user" "all_users" {
  for_each          = toset(flatten([for group in var.users_to_groups : group.value]))
  identity_store_id = tolist(data.aws_ssoadmin_instances.id.identity_store_ids)[0]

  alternate_identifier {
    unique_attribute {
      attribute_path  = "UserName"
      attribute_value = each.value
    }
  }
}
#
data "aws_identitystore_group" "groups" {
  for_each          = { for group_info in var.users_to_groups : group_info.group => group_info }
  identity_store_id = tolist(data.aws_ssoadmin_instances.id.identity_store_ids)[0]

  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = each.key # Ahora each.key es el nombre del grupo
    }
  }
}
#
locals {
  user_group_pairs = flatten([
    for group_info in var.users_to_groups : [
      for user_name in group_info.value : {
        user  = user_name
        group = group_info.group
      }
    ]
  ])
}
#
resource "aws_identitystore_group_membership" "users_membership" {
  for_each          = { for pair in local.user_group_pairs : "${pair.user}-${pair.group}" => pair }
  identity_store_id = tolist(data.aws_ssoadmin_instances.id.identity_store_ids)[0]

  member_id = data.aws_identitystore_user.all_users[each.value.user].user_id

  group_id = data.aws_identitystore_group.groups[each.value.group].group_id
}
#
