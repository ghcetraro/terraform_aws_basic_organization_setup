#
data "aws_ssoadmin_permission_set" "developers" {
  instance_arn = tolist(data.aws_ssoadmin_instances.id.arns)[0]
  name         = "developers" # Name of the existing Permission Set
}
#
data "aws_identitystore_group" "developers" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.id.identity_store_ids)[0]

  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = "developers"
    }
  }
}
#
#
data "aws_iam_policy_document" "developers" {
  statement {
    sid = "ecr"
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage"
    ]
    resources = ["*"]
  }
  statement {
    sid = "ec2"
    actions = [
      "ec2:Describe*"
    ]
    resources = ["*"]
  }
  statement {
    sid = "eks"
    actions = [
      "eks:Describe*",
      "eks:List*",
      "eks:AccessKubernetesApi",
      "aps:ListScrapers",
      "account:GetAccountInformation",
      "account:ListRegions",
      "sts:AssumeRole",
      "sts:GetCallerIdentity",
      "sts:GetSessionToken",
      "iam:Get*",
      "iam:List*",
      "iam:PassRole",
      "iam:GenerateCredentialReport",
      "iam:GenerateServiceLastAccessedDetails",
      "iam:SimulateCustomPolicy",
      "iam:SimulatePrincipalPolicy",
      "organizations:DescribeEffectivePolicy",
      "organizations:DescribeOrganization"
    ]
    resources = ["*"]
  }
}
#
resource "aws_ssoadmin_permission_set_inline_policy" "developers" {
  inline_policy      = data.aws_iam_policy_document.developers.json
  instance_arn       = tolist(data.aws_ssoadmin_instances.id.arns)[0]
  permission_set_arn = data.aws_ssoadmin_permission_set.developers.arn
}
#
resource "aws_ssoadmin_managed_policy_attachment" "developers_ecr" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.id.arns)[0]
  permission_set_arn = data.aws_ssoadmin_permission_set.developers.arn
  managed_policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}
#
resource "aws_ssoadmin_managed_policy_attachment" "developers_ec2" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.id.arns)[0]
  permission_set_arn = data.aws_ssoadmin_permission_set.developers.arn
  managed_policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}
#
resource "aws_ssoadmin_managed_policy_attachment" "developers_rds" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.id.arns)[0]
  permission_set_arn = data.aws_ssoadmin_permission_set.developers.arn
  managed_policy_arn = "arn:aws:iam::aws:policy/AmazonRDSReadOnlyAccess"
}
#
resource "aws_ssoadmin_managed_policy_attachment" "developers_s3" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.id.arns)[0]
  permission_set_arn = data.aws_ssoadmin_permission_set.developers.arn
  managed_policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}
#
resource "aws_ssoadmin_managed_policy_attachment" "developers_cloudwatch" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.id.arns)[0]
  permission_set_arn = data.aws_ssoadmin_permission_set.developers.arn
  managed_policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsReadOnlyAccess"
}
#
resource "aws_ssoadmin_managed_policy_attachment" "developers_documentdb" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.id.arns)[0]
  permission_set_arn = data.aws_ssoadmin_permission_set.developers.arn
  managed_policy_arn = "arn:aws:iam::aws:policy/AmazonDocDBReadOnlyAccess"
}
#
resource "aws_ssoadmin_account_assignment" "developers_pepe_development" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.id.arns)[0]
  permission_set_arn = data.aws_ssoadmin_permission_set.developers.arn
  principal_id       = data.aws_identitystore_group.developers.group_id
  principal_type     = "GROUP"
  target_id          = var.list_of_accounts_ids.development
  target_type        = "AWS_ACCOUNT"
}
#