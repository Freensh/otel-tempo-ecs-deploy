resource "aws_ecs_service" "service" {
    name = var.service_name
    cluster = var.cluster_arn
    task_definition = aws_ecs_task_definition.otel_gateway.arn

    desired_count = var.desired_replicat
    launch_type = "FARGATE"

    deployment_minimum_healthy_percent = 50
    deployment_maximum_percent = 200

    network_configuration {
      subnets = var.subnets
      security_groups = var.security_groups
      assign_public_ip = var.assign_public_ip
    }
    load_balancer {
      target_group_arn = var.tg_group_arn
      container_name = var.service_name
      container_port = var.container_port
    }
    
    service_registries {
      registry_arn = aws_service_discovery_service.otel.arn
    }

    lifecycle {
      ignore_changes = [ task_definition ]
    }
}

resource "aws_ecs_task_definition" "otel_gateway" {

  family = var.service_name

  requires_compatibilities = ["FARGATE"]

  network_mode = "awsvpc"

  cpu = 512
  memory = 1024

  execution_role_arn = var.execution_role_arn
  task_role_arn      = var.task_role_arn

  container_definitions = jsonencode([
    {
      name = "${var.service_name}"

      image = "${var.otel_collector_image}"

      portMappings = [
        { containerPort = 4317 },
        { containerPort = 4318 }
      ]

      environment = [
        {
          name = "TEMPO_ENDPOINT"
          value = var.tempo_distributor_dns
        }
      ]
      logConfiguration = {
                logDriver = "awslogs"
                options = {
                    awslogs-group = "${var.otel_log_group}"
                    awslogs-region = "${var.region}"
                    awslogs-stream-prefix = "collector"
                }
            }
    }
  ])
}

resource "aws_service_discovery_service" "otel" {
  name = var.service_name

  dns_config {
    namespace_id = var.cloudmap_arn

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }
 
}