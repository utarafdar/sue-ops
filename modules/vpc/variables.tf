variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}
variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}
variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}
variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}
variable "env" {
  description = "Environment name"
  type        = string
}
