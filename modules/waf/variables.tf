variable "name" {
  description = "Name of the WAF Web ACL"
  type        = string
}

variable "description" {
  description = "Description of the WAF Web ACL"
  type        = string
}

variable "resource_arn" {
  description = "ARN of the resource to associate with the WAF (e.g., ALB)"
  type        = string
}