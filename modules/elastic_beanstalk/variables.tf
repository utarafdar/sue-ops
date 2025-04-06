variable "app_name" {
  description = "Name of the Elastic Beanstalk application"
  type        = string
}

variable "app_description" {
  description = "Description of the Elastic Beanstalk application"
  type        = string
  default     = "Elastic Beanstalk Application"
}

variable "env_name" {
  description = "Name of the Elastic Beanstalk environment"
  type        = string
}

variable "solution_stack_name" {
  description = "Elastic Beanstalk solution stack (e.g., '64bit Amazon Linux 2 v3.4.10 running Node.js 14')"
  type        = string
}

variable "instance_type" {
  description = "Instance type for Elastic Beanstalk instances"
  type        = string
  default     = "t3.micro"
}

variable "beanstalk_service_role" {
  description = "IAM role that Elastic Beanstalk assumes to manage resources"
  default     = "aws-elasticbeanstalk-service-role"
  type        = string
}

variable "ec2_instance_sg_ids" {
  description = "List of security group IDs for EC2 instances"
  type        = list(string)
  default     = []
}

variable "load_balancer_sg_ids" {
  description = "List of security group IDs for the Load Balancer"
  type        = list(string)
  default     = []
}

variable "ec2_instance_profile" {
  description = "IAM instance profile for EC2 instances in the environment"
  default     = "aws-elasticbeanstalk-ec2-role"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for Elastic Beanstalk"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnets for the Elastic Beanstalk load balancer"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnets for Elastic Beanstalk instances and load balancer"
  type        = list(string)
}

variable "min_size" {
  description = "Minimum number of instances in the Elastic Beanstalk environment"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of instances in the Elastic Beanstalk environment"
  type        = number
  default     = 2
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
