output "application_name" {
  value = aws_elastic_beanstalk_application.app.name
}

output "environment_name" {
  value = aws_elastic_beanstalk_environment.env.name
}

output "env_endpoint_url" {
  description = "The endpoint URL of the Elastic Beanstalk environment"
  value       = aws_elastic_beanstalk_environment.env.endpoint_url
}

output "load_balancer_arn" {
  description = "The ARN of the load balancer created by Elastic Beanstalk"
  value       = data.aws_lb.beanstalk_lb.arn
}