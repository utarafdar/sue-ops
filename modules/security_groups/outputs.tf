output "eb_load_balancer_sg_id" {
  value = aws_security_group.eb_load_balancer.id
}

output "eb_instances_sg_id" {
  value = aws_security_group.eb_instances.id
}