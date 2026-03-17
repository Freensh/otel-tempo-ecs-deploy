
######Deployment  OpenTelemetry Collector
module "otel_collector" {
  source       = "../../modules/otel-collector"
  region       = var.region
  service_name = var.otel_collector_dns
  cluster_arn  = data.aws_ecs_cluster.ecs_cluster.arn

  desired_replicat = var.otel_desired_capacity

  security_groups  = var.otel_sg
  subnets          = var.private_subnets
  assign_public_ip = false
  tg_group_arn     = module.otel_collector_lb.target_group_arn
  cloudmap_arn     = module.namespace.cloudmap_arn

  container_port       = var.otel_container_port
  otel_collector_image = data.aws_ecr_image.otel_image.image_uri

  execution_role_arn    = var.execution_role_arn
  task_role_arn         = var.execution_role_arn
  tempo_distributor_dns = "${var.tempo_dns}.${var.internal_dns}:${var.tempo_container_port}"
  otel_log_group        = module.otel_log_group.name
}

####Deployment Grafana Tempo
module "grafana_tempo" {
  source       = "../../modules/tempo"
  region       = var.region
  service_name = var.tempo_dns
  cluster_arn  = data.aws_ecs_cluster.ecs_cluster.arn

  desired_replicat = var.tempo_desired_capacity

  security_groups  = var.tempo_sg
  subnets          = var.private_subnets
  assign_public_ip = false
  cloudmap_arn     = module.namespace.cloudmap_arn

  tempo_image = data.aws_ecr_image.tempo_image.image_uri
  tempo_port  = var.tempo_container_port
  cpu         = var.tempo_container_cpu
  memory      = var.tempo_container_memory

  execution_role_arn = var.execution_role_arn
  task_role_arn      = var.execution_role_arn
  tempo_log_group    = module.tempo_log_group.name
}
#### Cloud Map namespace
module "namespace" {
  source        = "../../modules/cloudmap"
  dns_namespace = var.internal_dns
  vpc_id        = data.aws_vpc.dev_vpc.id
}

###### Otel internal Load balancer
module "otel_collector_lb" {
  source       = "../../modules/Loadbalancer"
  org          = var.org
  env          = var.env
  service_name = var.otel_collector_dns

  vpc_id          = data.aws_vpc.dev_vpc.id
  subnets         = var.private_subnets
  security_groups = var.otel_sg

  container_port = var.otel_container_port
}

#### CloudWatch log groups from OpenTelemetry Collector and Tempo
module "otel_log_group" {
  source       = "../../modules/logging"
  env          = var.env
  service_name = var.otel_collector_dns
}
module "tempo_log_group" {
  source       = "../../modules/logging"
  env          = var.env
  service_name = var.tempo_dns
}

##OpenTelemetry Collector autoscalling

module "otel_collector_autoscalling" {
  source       = "../../modules/autoscalling"
  service_name = module.otel_collector.service_name
  cluster_name = var.cluster_name
  max_capacity = var.otel_max_capacity
  min_capacity = var.otel_min_capacity
}

