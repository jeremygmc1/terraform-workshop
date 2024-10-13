variable "prefix" {
  type        = string
  description = "Prefix of your ecs cluster name"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet ids"
  default     = ["subnet-0030e65ee7c549f5d", "subnet-0dd39de08e95d80a6"]
}

variable "ecs_tasks_sg_ids" {
  type        = list(string)
  description = "List of ECS task security group ids"
}

variable "lb_sg_ids" {
  type        = set(string)
  description = "Load balancer's security group ids"
}

variable "vpc_id" {
  type        = string
  description = "VPC's id"
}

variable "aws_region" {
  type        = string
  description = "The region to deploy your apps to"
  default     = "ap-southeast-1" # Singapore
}

variable "nestjs_app_image" {
  type        = string
  description = "Docker image to run in the ECS cluster"
  default     = "smithquaz/intro-cloud-deployment-nestjs:latest"
}

variable "springboot_app_image" {
  type        = string
  description = "Docker image to run in the ECS cluster"
  default     = "smithquaz/intro-cloud-deployment-springboot:latest"
}

variable "app_count" {
  type        = number
  description = "Number of docker containers to run"
  default     = 3
}

variable "app_port" {
  type        = number
  description = "The port your app listens to"
  default     = 3000
}

variable "health_check_path" {
  type        = string
  default     = "/api/v1/health"
  description = "Health check path of the app"
}

variable "fargate_cpu" {
  type        = string
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
}

variable "fargate_memory" {
  type        = string
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
}

variable "nestjs_db_endpoint" {
  type        = string
  description = "Endpoint of your NestJs DB writer instance"
}

variable "springboot_db_endpoint" {
  type        = string
  description = "Endpoint of your Spring Boot DB writer instance"
}

variable "database_name" {
  type        = string
  description = "Name of the database"
}

variable "database_username" {
  type        = string
  description = "Username to connect to the database"
}

variable "database_password" {
  type        = string
  description = "Password to connect to the database"
}
