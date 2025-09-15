variable "general_config" {
  type = map(any)
}
variable "task_role" {}
variable "filter_pattern" {}
variable "destination_arn" {}
variable "kinesis_firehose_arn" {}