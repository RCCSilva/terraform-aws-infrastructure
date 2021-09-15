resource "aws_lb_target_group" "service_application" {
  name     = "${var.application_name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc.id
}

resource "aws_ecs_service" "service" {
  name            = "${var.application_name}-sc"
  cluster         = var.cluster.id
  task_definition = var.task_definition.arn
  desired_count   = var.desired_count
  iam_role        = var.ecs_execution_role.arn
  launch_type     = "FARGATE"


  load_balancer {
    target_group_arn = aws_lb_target_group.service_application.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
}
