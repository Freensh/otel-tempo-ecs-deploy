output "cloudmap_arn" {
  value = aws_service_discovery_private_dns_namespace.dns_namespaces.id
}