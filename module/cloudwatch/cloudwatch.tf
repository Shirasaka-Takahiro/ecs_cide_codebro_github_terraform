##Cloudwatch Log Group
resource "aws_cloudwatch_log_group" "deafult" {
  name              = "/ecs/${var.general_config["project"]}/${var.general_config["env"]}/${var.task_role}"
  retention_in_days = 30
}

##Cloudwatch Log Subscription Filter
resource "aws_cloudwatch_log_subscription_filter" "default" {
  name            = "${var.general_config["project"]}-${var.general_config["env"]}-logging-subscription-filter"
  role_arn        = aws_iam_role.kinesis_cloudwatchlogs_role.arn
  log_group_name  = aws_cloudwatch_log_group.deafult.name
  filter_pattern  = var.filter_pattern
  destination_arn = var.destination_arn
}