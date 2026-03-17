resource "aws_service_discovery_private_dns_namespace" "dns_namespaces" {
  name = var.dns_namespace
  vpc  = var.vpc_id
}