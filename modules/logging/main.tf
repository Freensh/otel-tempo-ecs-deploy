resource "aws_cloudwatch_log_group" "service_lg" {
  name              = "/ecs/${var.env}/${var.service_name}"
  retention_in_days = 30
}