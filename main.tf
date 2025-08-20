provider "aws" {
  region = var.region
}

data "terraform_remote_state" "aws-networking" {
  backend = "remote"

  config = {
    organization = var.TFE_ORG_NAME
    workspaces = {
      name = "aws-networking"
    }
  }
}

resource "random_password" "db_password" {
  length  = 16
  special = true
}

resource "random_string" "random_str" {
  length  = 6
  numeric = false
  special = false
  upper   = false
}

resource "aws_db_parameter_group" "db_param_group" {
  name   = "${var.db_name}-${random_string.random_str.id}"
  family = "postgres16"

  parameter {
    name  = "log_connections"
    value = "1"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_db_instance" "db" {
  identifier             = "${var.db_name}-${random_string.random_str.id}"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  apply_immediately      = true
  engine                 = "postgres"
  engine_version         = "16.6"
  username               = var.db_admin
  password               = resource.random_password.db_password.result
  db_subnet_group_name   = data.terraform_remote_state.aws-networking.outputs.db_subnet_group_name
  vpc_security_group_ids = [data.terraform_remote_state.aws-networking.outputs.psql_security_group_id.id]
  parameter_group_name   = aws_db_parameter_group.db_param_group.name
  publicly_accessible    = true
  skip_final_snapshot    = true
}