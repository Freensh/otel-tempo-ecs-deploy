data "aws_vpc" "dev_vpc" {
  filter {
    name   = "tag:Name"
    values = ["${var.vpc_name}"]
  }
  filter {
    name   = "tag:Env"
    values = ["${var.env}"]
  }
}

data "aws_subnets" "private_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.dev_vpc.id]
  }
  tags = {
    Tier = "Private"
  }

  depends_on = [ data.aws_vpc.dev_vpc ]
}
data "aws_ecs_cluster" "ecs_cluster" {
  cluster_name = var.cluster_name
}
data "aws_ecr_image" "otel_image" {
  repository_name = "freenshdev-otel-repo"
  image_tag       = "0.91.0"
}
data "aws_ecr_image" "tempo_image" {
  repository_name = "freenshdev-tempo-repo"
  image_tag       = "2.4.1"
}
