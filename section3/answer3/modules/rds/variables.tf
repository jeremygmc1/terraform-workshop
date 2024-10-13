variable "prefix" {
  type        = string
  description = "Prefix to be added to all resources"
}

variable "security_group_id" {
  type        = string
  description = "Security Group ID of to be used by the DB"
}

variable "database_name" {
  type        = string
  description = "The name of the database"
}

variable "database_username" {
  type        = string
  description = "The username for the database"
}

variable "database_password" {
  type        = string
  description = "value of the password for the database"
}

variable "tf_workshop_ex3_private_subnet_1_id" {
  type        = string
  description = "The ID of the Private Subnet 1 for Exercise 3"
  default     = "subnet-0dd9714c2820df944"
}

variable "tf_workshop_ex3_private_subnet_2_id" {
  type        = string
  description = "The ID of the Private Subnet 2 for Exercise 3"
  default     = "subnet-0abe9cf7224a901af"
}
