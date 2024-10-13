output "nestjs_alb_hostname" {
  value = "${aws_alb.nestjs_main.dns_name}:3000"
}

output "springboot_alb_hostname" {
  value = "${aws_alb.springboot_main.dns_name}:3000"
}
