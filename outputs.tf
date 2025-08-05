output "admin_username" {
  description = "The admin username"
  value       = aws_rds_cluster.aurora_pg.master_username
  sensitive   = true
}

output "admin_password" {
  description = "The admin password"
  value       = random_password.master.result
  sensitive   = true
}

output "db_name" {
  description = "Database instance name"
  value       = var.db_name
  sensitive   = true
}

output "db_connection_string" {
  description = "Database connection string"
  value = "postgresql://${aws_rds_cluster.aurora_pg.master_username}:${random_password.master.result}@${aws_rds_cluster.aurora_pg.endpoint}:${aws_rds_cluster.aurora_pg.port}/${var.db_name}"
  sensitive = true
}