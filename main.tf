provider "aws" {
  region = var.region
}

data "terrafom_remote_state" "aws-networking" {
  backend = "remote"

  config = {
    organization = var.TFE_ORG_NAME
    workspaces = {
      name = "aws-networking"
    }
  }
}

resource "random_password" "master" {
  length  = 16
  special = true
}

resource "aws_rds_cluster" "aurora_pg" {
  cluster_identifier      = "aurora-psql-${var.db_name}"
  engine                 = "aurora-postgresql"
  master_username        = var.db_admin
  master_password        = random_password.master.result
  database_name          = var.db_name
  db_subnet_group_name = data.terrafom_remote_state.aws-networking.outputs.db_subnet_group_name
  skip_final_snapshot    = true
}

resource "aws_rds_cluster_instance" "aurora_pg_instance" {
  count                  = 1
  identifier             = "aurora-psql-${var.db_name}-instance"
  cluster_identifier     = aws_rds_cluster.aurora_pg.id
  instance_class         = var.instance_class
  engine                 = aws_rds_cluster.aurora_pg.engine
}