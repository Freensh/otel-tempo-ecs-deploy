
variable "otel_sg" {
  type = list(string)
}
variable "internal_dns" {
  type = string
}
variable "vpc_name" {
  type = string
}
variable "org" {
  type = string
}
variable "env" {
  type = string
}
variable "otel_container_port" {
  type = number
}
variable "otel_collector_dns" {
  type = string
}
variable "tempo_dns" {
  type = string
}
variable "cluster_name" {
  type = string
}
variable "otel_max_capacity" {
  type = number
}
variable "otel_min_capacity" {
  type = number
}
variable "execution_role_arn" {
  type = string
}
variable "otel_collector_image" {
  type = string
}
variable "otel_desired_capacity" {
  type = number
}
variable "tempo_desired_capacity" {
  type = number
}
variable "tempo_sg" {
  type = list(string)
}
variable "tempo_image" {
  type = string
}
variable "tempo_container_port" {
  type = number
}
variable "region" {
  type = string
}
variable "tempo_container_cpu" {
  type = number
}
variable "tempo_container_memory" {
  type = number
}
variable "private_subnets" {
  type = list(string)
}
