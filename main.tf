provider "aws" {
  region = var.region
}

resource "random_password" "master" {
  length  = 16
  special = true
}

resource "aws_rds_cluster" "aurora_pg" {
  cluster_identifier      = "aurora-${var.db_name}"
  engine                 = "aurora-postgresql"
  master_username        = var.db_admin
  master_password        = random_password.master.result
  database_name          = var.db_name
  skip_final_snapshot    = true
}

resource "aws_rds_cluster_instance" "aurora_pg_instance" {
  count                  = 1
  identifier             = "aurora-${var.db_name}-instance"
  cluster_identifier     = aws_rds_cluster.aurora_pg.id
  instance_class         = var.instance_class
  engine                 = aws_rds_cluster.aurora_pg.engine
}