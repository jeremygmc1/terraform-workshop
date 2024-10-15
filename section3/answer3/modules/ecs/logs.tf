# Set up CloudWatch group and log stream and retain logs for 7 days
resource "aws_cloudwatch_log_group" "nestjs_log_group" {
  name              = "/ecs/${var.student_id}-nestjs-todo-app"
  retention_in_days = 7

  tags = {
    Name = "nestjs-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "nestjs_log_stream" {
  name           = "${var.student_id}-nestjs-log-stream"
  log_group_name = aws_cloudwatch_log_group.nestjs_log_group.name
}


resource "aws_cloudwatch_log_group" "springboot_log_group" {
  name              = "/ecs/${var.student_id}-springboot-todo-app"
  retention_in_days = 7

  tags = {
    Name = "springboot-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "springboot_log_stream" {
  name           = "${var.student_id}-springboot-log-stream"
  log_group_name = aws_cloudwatch_log_group.springboot_log_group.name
}
