# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "nestjs_log_group" {
  name              = "/ecs/${var.prefix}-nestjs-todo-app"
  retention_in_days = 30

  tags = {
    Name = "nestjs-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "nestjs_log_stream" {
  name           = "${var.prefix}-nestjs-log-stream"
  log_group_name = aws_cloudwatch_log_group.nestjs_log_group.name
}


resource "aws_cloudwatch_log_group" "springboot_log_group" {
  name              = "/ecs/${var.prefix}-springboot-todo-app"
  retention_in_days = 30

  tags = {
    Name = "springboot-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "springboot_log_stream" {
  name           = "${var.prefix}-springboot-log-stream"
  log_group_name = aws_cloudwatch_log_group.springboot_log_group.name
}
