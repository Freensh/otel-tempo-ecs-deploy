
variable "subnets" {
  type = list(string)
}
variable "security_groups" {
  type = list(string)
}
variable "org" {
    type = string
}
variable "env" {
    type = string
}
variable "service_name" {
  type = string
}
variable "container_port" {
  type = number
}
variable "vpc_id" {
  type = string
}