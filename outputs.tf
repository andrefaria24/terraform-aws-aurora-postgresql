output "db_username" {
  description = "The admin username"
  value       = aws_db_instance.db.username
}

output "db_password" {
  description = "The admin password"
  value       = resource.random_password.db_password.result
  sensitive   = true
}

output "db_hostname" {
  description = "Database hostname"
  value       = resource.aws_db_instance.db.address
}

output "db_name" {
  description = "Database instance name"
  value       = var.db_name
}

output "db_port" {
  description = "Database port"
  value       = resource.aws_db_instance.db.port
}

output "db_connection_endpoint" {
  description = "Database connection endpoint"
  value       = resource.aws_db_instance.db.endpoint
}