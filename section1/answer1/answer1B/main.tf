# format: "resource_type" "resource_name"
resource "aws_instance" "app_server" {
  # specify arguments here
  ami           = var.ec2_ami      # EC2 AMI
  instance_type = var.ec2_instance_type  # EC2 Instance Type

  associate_public_ip_address = true
  subnet_id                   = var.tf_workshop_ex1_subnet_id
  vpc_security_group_ids      = [var.tf_workshop_ex1_vpc_sg_id]

  tags = {
    Name = "${var.student_id}-Ex1-EC2-Instance"
  }
}

variable "ec2_ami" {
  type        = string
  description = "AMI ID for the EC2 instance"
  default     = "ami-0ad522a4a529e7aa8"
}

variable "ec2_instance_type" {
  type        = string
  description = "Instance type for the EC2 instance"
  default     = "t3.small"
}

variable "student_name" {
  type        = string
  description = "Name of the student for tagging purposes"
  default     = "[StudentName]"
}
