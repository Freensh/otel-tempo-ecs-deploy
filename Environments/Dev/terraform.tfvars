#####  Environment
region = "ca-central-1"
env    = "Dev"
org    = "Freensh"
cluster_name = "Freensh-Dev-Cluster"

#####  Networking
internal_dns = "obervability.local"
vpc_name     = "Freensh-Dev-vpc"
private_subnets = [ "subnet-01722558727ee1ac4", "subnet-0548160856f0123a8", "subnet-04612e6fe9ae06092" ]

###OpenTelemetry
otel_collector_dns    = "otel"
otel_collector_image  = "dhi.io/opentelemetry-collector:latest"
otel_container_port   = 4317
otel_desired_capacity = 2
otel_min_capacity     = 2
otel_max_capacity     = 5
otel_sg               = ["sg-0417f90973ef5ac78"]

### Grafana tempo
tempo_dns              = "tempo"
tempo_image            = "dhi.io/tempo:latest"
tempo_container_port   = 3200
tempo_container_cpu    = 512
tempo_container_memory = 1024
tempo_desired_capacity = 2
tempo_sg               = ["sg-0cc531a8f6b02775e"]

#### Execution role
execution_role_arn = "arn:aws:iam::885684264653:role/FreenshDevExexutionRole"