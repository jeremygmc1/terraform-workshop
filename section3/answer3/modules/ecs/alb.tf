resource "aws_alb" "nestjs_main" {
  name            = "${var.student_id}-nestjs-lb"
  subnets         = var.public_subnet_ids
  security_groups = var.lb_sg_ids
}

resource "aws_alb_target_group" "nestjs_app" {
  name        = "${var.student_id}-nestjs-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = 2
    interval            = 30
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = 3
    path                = var.health_check_path
    unhealthy_threshold = 2
  }
}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "nestjs_front_end" {
  load_balancer_arn = aws_alb.nestjs_main.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.nestjs_app.id
    type             = "forward"
  }
}

resource "aws_alb" "springboot_main" {
  name            = "${var.student_id}-springboot-lb"
  subnets         = var.public_subnet_ids
  security_groups = var.lb_sg_ids
}

resource "aws_alb_target_group" "springboot_app" {
  name        = "${var.student_id}-springboot-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = 2
    interval            = 30
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = 3
    path                = var.health_check_path
    unhealthy_threshold = 2
  }
}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "springboot_front_end" {
  load_balancer_arn = aws_alb.springboot_main.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.springboot_app.id
    type             = "forward"
  }
}
