# Note: This value is hard coded for the purpose of the workshop. 
# In a real-world scenario, you would want to use a data source to look up the VPC ID.
variable "tf_workshop_ex3_vpc_id" {
  type        = string
  description = "The ID of the VPC for Exercise 3"
  default     = "vpc-0f4d49126323c6e56"
}

variable "tf_workshop_ex3_database_name" {
  type        = string
  description = "The name of the database"
  default     = "demodb"
}

variable "tf_workshop_ex3_database_username" {
  type        = string
  description = "The username for the database"
  default     = "root"
}

variable "tf_workshop_ex3_db_password" {
  type        = string
  description = "value of the password for the database"
  default     = "TerraformRocksPa33W0rd!"
}
