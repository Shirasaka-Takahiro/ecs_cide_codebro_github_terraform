variable "general_config" {
  type = map(any)
}
variable "destination" {}
variable "bucket_arn" {}
variable "buffering_size" {}
variable "buffering_interval" {}
variable "prefix" {}