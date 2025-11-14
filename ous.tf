#
data "aws_organizations_organization" "current" {}
#
# Create ous
resource "aws_organizations_organizational_unit" "ou" {
  for_each = toset(var.ous)
  #
  name      = each.key
  parent_id = data.aws_organizations_organization.current.roots[0].id
}
#
# Create accounts
resource "aws_organizations_account" "member" {
  for_each = var.member_accounts
  #
  name              = each.value.name
  email             = each.value.email
  close_on_deletion = each.value.close_on_deletion
  #
  parent_id = aws_organizations_organizational_unit.ou[each.value.ou_name].id
}
#