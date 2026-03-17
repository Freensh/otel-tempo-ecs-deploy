resource "aws_ecs_service" "service" {
    name = var.service_name
    cluster = var.cluster_arn
    task_definition = aws_ecs_task_definition.tempo.arn

    desired_count = var.desired_replicat
    launch_type = "FARGATE"

    deployment_minimum_healthy_percent = 50
    deployment_maximum_percent = 200

    network_configuration {
      subnets = var.subnets
      security_groups = var.security_groups
      assign_public_ip = var.assign_public_ip
    }
    service_registries {
      registry_arn = aws_service_discovery_service.tempo.arn
    }

    lifecycle {
      ignore_changes = [ task_definition ]
    }
}

resource "aws_ecs_task_definition" "tempo" {
    family = var.service_name
    network_mode = "awsvpc"
    requires_compatibilities = ["FARGATE"]

    container_definitions = jsonencode([
        {
            name = "${var.service_name}"
            image = "${var.tempo_image}"

            essential = true
            portMapping = [
                {
                    containerPort = "${var.tempo_port}"
                    protocol = "TCP"
                }
            ]

            logConfiguration = {
                logDriver = "awslogs"
                options = {
                    awslogs-group = "${var.tempo_log_group}"
                    awslogs-region = "${var.region}"
                    awslogs-stream-prefix = "tempo"
                }
            }

        }
    ])
    cpu = var.cpu
    memory = var.memory

    execution_role_arn = var.execution_role_arn
    task_role_arn = var.task_role_arn
}
resource "aws_service_discovery_service" "tempo" {
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