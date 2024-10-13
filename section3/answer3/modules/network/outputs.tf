output "vpc_id" {
  value = var.tf_workshop_ex3_vpc_id
}
output "lb_sg_id" {
  value = aws_security_group.lb_sg.id
}

output "ecs_tasks_sg_id" {
  value = aws_security_group.ecs_tasks_sg.id
}

output "db_sg_id" {
  value = aws_security_group.db_sg.id
}
