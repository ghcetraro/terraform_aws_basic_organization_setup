#
data "aws_iam_policy_document" "staging" {
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
      "eks:DescribeCluster",
      "eks:ListClusters",
      "eks:ListFargateProfiles",
      "eks:ListNodegroups",
      "eks:ListUpdates",
      "eks:DescribeFargateProfile",
      "eks:DescribeNodegroup",
      "eks:DescribeUpdate"
    ]
    resources = ["*"]
  }
  statement {
    sid = "cloudwatch"
    actions = [
      "cloudwatch:GetMetricData",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:ListMetrics",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:DescribeAlarmsForMetric",
      "cloudwatch:ListDashboards",
      "cloudwatch:GetDashboard",
      "cloudwatch:DescribeInsightRules"
    ]
    resources = ["*"]
  }
  statement {
    sid = "rds"
    actions = [
      "rds:DescribeDBInstances",
      "rds:DescribeDBClusters",
      "rds:DescribeDBParameterGroups",
      "rds:DescribeDBClusterParameterGroups",
      "rds:DescribeDBSnapshots",
      "rds:DescribeEventSubscriptions",
      "rds:DescribeRegions",
      "rds:ListTagsForResource"
    ]
    resources = ["*"]
  }
  statement {
    sid = "elasticache"
    actions = [
      "elasticache:DescribeCacheClusters",
      "elasticache:DescribeReplicationGroups",
      "elasticache:DescribeCaches",
      "elasticache:ListTagsForResource"
    ]
    resources = ["*"]
  }
  statement {
    sid = "docdb"
    actions = [
      "docdb:DescribeDBInstances",
      "docdb:DescribeDBClusters",
      "docdb:DescribeEventSubscriptions",
      "docdb:DescribeDBClusterParameterGroups",
      "docdb:ListTagsForResource"
    ]
    resources = ["*"]
  }
  statement {
    sid = "sns"
    actions = [
      "sns:ListSubscriptions",
      "sns:ListSubscriptionsByTopic",
      "sns:ListTopics",
      "sns:GetTopicAttributes",
      "sns:ListTagsForResource"
    ]
    resources = ["*"]
  }
  statement {
    sid = "sqs"
    actions = [
      "sqs:ListQueues",
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:ListQueueTags"
    ]
    resources = ["*"]
  }
}
#
resource "aws_ssoadmin_permission_set_inline_policy" "staging" {
  inline_policy      = data.aws_iam_policy_document.staging.json
  instance_arn       = tolist(data.aws_ssoadmin_instances.id.arns)[0]
  permission_set_arn = data.aws_ssoadmin_permission_set.staging.arn
}
#
data "aws_ssoadmin_permission_set" "staging" {
  instance_arn = tolist(data.aws_ssoadmin_instances.id.arns)[0]
  name         = "staging" # Name of the existing Permission Set
}
#
data "aws_identitystore_group" "staging" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.id.identity_store_ids)[0]

  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = "staging"
    }
  }
}
#
resource "aws_ssoadmin_account_assignment" "staging_pepe_staging" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.id.arns)[0]
  permission_set_arn = data.aws_ssoadmin_permission_set.staging.arn
  principal_id       = data.aws_identitystore_group.staging.group_id
  principal_type     = "GROUP"
  target_id          = var.list_of_accounts_ids.staging
  target_type        = "AWS_ACCOUNT"
}