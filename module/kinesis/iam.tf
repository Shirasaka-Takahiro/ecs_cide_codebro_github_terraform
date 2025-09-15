data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

resource "aws_iam_role" "kinesis_firehose_role" {
  name = "${var.general_config["project"]}-${var.general_config["env"]}-delivery-stream-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "firehose.amazonaws.com"
        }
      },
    ]
  })

  managed_policy_arns = [
    aws_iam_policy.kinesis_firehose_policy.arn
  ]
}

resource "aws_iam_policy" "kinesis_firehose_policy" {
  name = "${var.general_config["project"]}-${var.general_config["env"]}-delivery-stream-policy"
  policy = templatefile(
    "${path.module}/iam_json/kinesis_firehose_policy.json",
    {
      region     = data.aws_region.current.id,
      account_id = data.aws_caller_identity.current.account_id,
      bucket_arn = var.bucket_arn
    }
  )
}