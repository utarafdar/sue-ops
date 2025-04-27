variable "name" {
  description = "Name of the bastion host"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the bastion host will be deployed"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID for the bastion host"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the bastion host"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the bastion host"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Key pair name for SSH access to the bastion host"
  type        = string
}