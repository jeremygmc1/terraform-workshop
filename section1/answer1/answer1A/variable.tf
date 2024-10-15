# Note: This value is hard coded for the purpose of the workshop. 
# In a real-world scenario, you would want to use a data source to look up the VPC ID.
variable "tf_workshop_ex1_vpc_sg_id" {
  type        = string
  description = "The ID of the VPC for Exercise 1"
  default     = "sg-0f9b9c5a891d88da4"
}

variable "tf_workshop_ex1_subnet_id" {
  type        = string
  description = "The ID of the Subnet for Exercise 1"
  default     = "subnet-0b9cc866875838ab6"
}

variable "student_id" {
  type        = string
  description = "Student ID"
  default     = "student-420"
}
