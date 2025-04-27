variable "name" {
  description = "Name/identifier for the DB"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "beanstalk_sg_id" {
  description = "Security group ID of Elastic Beanstalk EC2 instances"
  type        = string
}

variable "db_username" {
  description = "DB username"
  type        = string
}

variable "db_password" {
  description = "DB password"
  type        = string
  sensitive   = true
}

variable "allocated_storage" {
  default     = 20
  description = "Storage in GB"
  type        = number
}

variable "instance_class" {
  default     = "db.t3.micro"
  description = "Instance class"
  type        = string
}

variable "bastion_sg_id" {
  description = "Security group ID of the bastion host"
  type        = string
}
