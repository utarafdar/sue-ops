output "db_instance_endpoint" {
  value = aws_db_instance.mariadb_instance.endpoint
}

output "security_group_id" {
  value = aws_security_group.rds_sg.id
}
