resource "aws_appautoscaling_target" "nestjs_target" {
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.nestjs_main.name}/${aws_ecs_service.nestjs_main.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  role_arn           = aws_iam_role.ecs_autoscaling_role.arn
  min_capacity       = 2
  max_capacity       = 3
  depends_on         = [aws_iam_role_policy_attachment.ecs_autoscaling_policy_attachment]
}

# Automatically scale capacity up by one
resource "aws_appautoscaling_policy" "nestjs_up" {
  name               = "scale_up"
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.nestjs_main.name}/${aws_ecs_service.nestjs_main.name}"
  scalable_dimension = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }

  depends_on = [aws_appautoscaling_target.nestjs_target]
}

# Automatically scale capacity down by one
resource "aws_appautoscaling_policy" "nestjs_down" {
  name               = "scale_down"
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.nestjs_main.name}/${aws_ecs_service.nestjs_main.name}"
  scalable_dimension = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = -1
    }
  }

  depends_on = [aws_appautoscaling_target.nestjs_target]
}

# CloudWatch alarm that triggers the autoscaling up policy
resource "aws_cloudwatch_metric_alarm" "nestjs_service_cpu_high" {
  alarm_name          = "cpu_utilization_high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "85"

  dimensions = {
    ClusterName = aws_ecs_cluster.nestjs_main.name
    ServiceName = aws_ecs_service.nestjs_main.name
  }

  alarm_actions = [aws_appautoscaling_policy.nestjs_up.arn]
}

# CloudWatch alarm that triggers the autoscaling down policy
resource "aws_cloudwatch_metric_alarm" "nestjs_service_cpu_low" {
  alarm_name          = "cpu_utilization_low"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "10"

  dimensions = {
    ClusterName = aws_ecs_cluster.nestjs_main.name
    ServiceName = aws_ecs_service.nestjs_main.name
  }

  alarm_actions = [aws_appautoscaling_policy.nestjs_down.arn]
}




resource "aws_appautoscaling_target" "springboot_target" {
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.springboot_main.name}/${aws_ecs_service.springboot_main.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  role_arn           = aws_iam_role.ecs_autoscaling_role.arn
  min_capacity       = 2
  max_capacity       = 3
  depends_on         = [aws_iam_role_policy_attachment.ecs_autoscaling_policy_attachment]
}

# Automatically scale capacity up by one
resource "aws_appautoscaling_policy" "springboot_up" {
  name               = "scale_up"
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.springboot_main.name}/${aws_ecs_service.springboot_main.name}"
  scalable_dimension = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }

  depends_on = [aws_appautoscaling_target.springboot_target]
}

# Automatically scale capacity down by one
resource "aws_appautoscaling_policy" "springboot_down" {
  name               = "scale_down"
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.springboot_main.name}/${aws_ecs_service.springboot_main.name}"
  scalable_dimension = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = -1
    }
  }

  depends_on = [aws_appautoscaling_target.springboot_target]
}

# CloudWatch alarm that triggers the autoscaling up policy
resource "aws_cloudwatch_metric_alarm" "springboot_service_cpu_high" {
  alarm_name          = "cpu_utilization_high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "85"

  dimensions = {
    ClusterName = aws_ecs_cluster.springboot_main.name
    ServiceName = aws_ecs_service.springboot_main.name
  }

  alarm_actions = [aws_appautoscaling_policy.springboot_up.arn]
}

# CloudWatch alarm that triggers the autoscaling down policy
resource "aws_cloudwatch_metric_alarm" "springboot_service_cpu_low" {
  alarm_name          = "cpu_utilization_low"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "10"

  dimensions = {
    ClusterName = aws_ecs_cluster.springboot_main.name
    ServiceName = aws_ecs_service.springboot_main.name
  }

  alarm_actions = [aws_appautoscaling_policy.springboot_down.arn]
}