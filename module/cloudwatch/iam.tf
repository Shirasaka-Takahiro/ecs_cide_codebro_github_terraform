data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

resource "aws_iam_role" "kinesis_cloudwatchlogs_role" {
  name = "${var.general_config["project"]}-${var.general_config["env"]}-kinesis-cloudwatchlogs-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "logs.amazonaws.com"
        }
      },
    ]
  })

  managed_policy_arns = [
    aws_iam_policy.kinesis_cloudwatchlogs_policy.arn
  ]
}

resource "aws_iam_policy" "kinesis_cloudwatchlogs_policy" {
  name = "${var.general_config["project"]}-${var.general_config["env"]}-kinesis-cloudwatchlogs-policy"
  policy = templatefile(
    "${path.module}/iam_json/kinesis_cloudwatchlogs_policy.json",
    {
      region               = data.aws_region.current.id,
      account_id           = data.aws_caller_identity.current.account_id,
      kinesis_firehose_arn = var.kinesis_firehose_arn,
      project              = var.general_config["project"],
      env                  = var.general_config["env"]
    }
  )
}