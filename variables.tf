#
variable "account" {}
variable "environment" {}
variable "region" {}
variable "project" {}
variable "role" {}
#
variable "list_of_accounts_ids" {}
#
variable "grupos" {
  default = null
}
#
variable "permission_set" {
  default = null
}
#
variable "permission_set_policies" {
  default = null
}
#
variable "users_to_groups" {}
#
variable "users" {}
#
variable "ous" {
  default = null
}
#
variable "member_accounts" {
  default = null
}