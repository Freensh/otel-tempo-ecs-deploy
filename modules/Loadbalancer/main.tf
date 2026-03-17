resource "aws_lb" "alb" {
  name = "${var.org}-${var.env}-lb"
  load_balancer_type = "application"

  subnets = var.subnets
  security_groups = var.security_groups
}

resource "aws_lb_target_group" "ecs" {
  name        = "${var.env}-${var.service_name}"
  port        = var.container_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path = "/health"
  }
}
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.ecs.arn
  }
}