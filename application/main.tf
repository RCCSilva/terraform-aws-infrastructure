
module "ecr" {
  source = "../ecr"

  application_name = var.application_name

}

resource "aws_ecs_task_definition" "service" {
  family = "${var.application_name}-td"
  cpu    = 256
  memory = 512

  container_definitions = jsonencode([
    {
      name      = var.application_name
      image     = "python3"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
        }
      ]
    }
  ])

  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
}


module "ecs_application" {
  source = "../ecs_application"

  application_name   = var.application_name
  cluster            = var.cluster
  task_definition    = aws_ecs_task_definition.service
  desired_count      = var.desired_count
  container_name     = var.application_name
  container_port     = var.container_port
  vpc                = var.vpc
  ecs_execution_role = aws_iam_role.ecs_execution_role
}

