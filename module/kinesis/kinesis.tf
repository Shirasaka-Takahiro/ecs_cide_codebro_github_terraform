resource "aws_kinesis_firehose_delivery_stream" "default" {
  name        = "${var.general_config["project"]}-${var.general_config["env"]}-delivery-stream"
  destination = var.destination

  extended_s3_configuration {
    role_arn           = aws_iam_role.kinesis_firehose_role.arn
    bucket_arn         = var.bucket_arn
    buffering_size     = var.buffering_size
    buffering_interval = var.buffering_interval
    prefix             = var.prefix
  }
}