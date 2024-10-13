resource "aws_ecs_cluster" "main" {
  name = "${var.prefix}-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "${var.prefix}-app-task"
  execution_role_arn       = aws_iam_role.ecs_tasks_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions = templatefile("./templates/ecs/todo_app.json.tpl", {
    app_image           = var.app_image
    app_port            = var.app_port
    fargate_cpu         = var.fargate_cpu
    fargate_memory      = var.fargate_memory
    aws_region          = var.aws_region
    DATABASE_HOST       = var.db_endpoint
    DATABASE_PORT       = 3306
    DATABASE_NAME       = "demodb"
    DATABASE_USER       = "root"
    DATABASE_PASSWORD   = "TfWorkshopPassw0rd"  # In production, you should use secret manager to store the password
  })
  depends_on               = [aws_iam_role_policy_attachment.task_execution_role_policy_attachment]
}

resource "aws_ecs_service" "main" {
  name            = "${var.prefix}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = var.ecs_tasks_sg_ids
    subnets          = var.public_subnet_ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.app.id
    container_name   = "todo-app" # Must match with the container name defined in template
    container_port   = var.app_port
  }

  depends_on = [aws_alb_listener.front_end, aws_iam_role_policy_attachment.task_execution_role_policy_attachment]
}
