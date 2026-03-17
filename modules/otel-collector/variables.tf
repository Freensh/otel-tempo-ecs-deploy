variable "service_name" {
  type = string
}
variable "cluster_arn" {
  type = string
}
variable "desired_replicat" {
  type = number
}
variable "container_port" {
  type = number
}

variable "tg_group_arn" {
  type = string
}
variable "subnets" {
  type = list(string)
}
variable "security_groups" {
  type = list(string)
}
variable "assign_public_ip" {
  type = bool
}
variable "cloudmap_arn" {
  type = string
}
variable "execution_role_arn" {
  type = string
}
variable "task_role_arn" {
  type = string
}
variable "otel_collector_image" {
  type = string
}
variable "tempo_distributor_dns" {
  type = string
}
variable "otel_log_group" {
  type = string
}
variable "region" {
  type = string
}