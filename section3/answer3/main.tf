locals {
  prefix = "student-number"
}


module "network" {
  source                 = "./modules/network"
  prefix                 = local.prefix
  tf_workshop_ex3_vpc_id = var.tf_workshop_ex3_vpc_id
}

module "rds" {
  source            = "./modules/rds"
  prefix            = local.prefix
  security_group_id = module.network.db_sg_id

  # Database Connection Credentials
  database_name     = var.tf_workshop_ex3_database_name
  database_username = var.tf_workshop_ex3_database_username
  database_password = var.tf_workshop_ex3_db_password

  applications = {
    "nestjs" = {
      identifier = "${local.prefix}-nestjs-terraform-workshop-db"
    },
    "springboot" = {
      identifier = "${local.prefix}-springboot-terraform-workshop-db"
    }
  }
}

module "ecs" {
  source                 = "./modules/ecs"
  prefix                 = local.prefix
  lb_sg_ids              = [module.network.lb_sg_id]
  vpc_id                 = var.tf_workshop_ex3_vpc_id
  ecs_tasks_sg_ids       = [module.network.ecs_tasks_sg_id]
  nestjs_db_endpoint     = module.rds.nestjs_db_endpoint
  springboot_db_endpoint = module.rds.springboot_db_endpoint

  # Database Connection Credentials
  database_name     = var.tf_workshop_ex3_database_name
  database_username = var.tf_workshop_ex3_database_username
  database_password = var.tf_workshop_ex3_db_password
}
