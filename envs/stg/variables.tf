variable "aws_region" {
  description = "AWS region to deploy to"
  type        = string
  default     = "eu-west-1"
}

variable "env" {
  description = "AWS environment name"
  type        = string
  default     = "stg"
}

variable "mariadb_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}
variable "mariadb_username" {
  description = "Database username"
  type        = string
  default     = "admin"
}
