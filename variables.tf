variable "db_name" {
  description = "Database Name"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
  validation {
    condition     = contains(["us-east-1", "us-east-2", "us-west-2", "eu-west-1"], var.region)
    error_message = "Supported regions: us-east-1, us-east-2, us-west-2, eu-west-1"
  }
}

variable "instance_class" {
  description = "Instance Size"
  type        = string
  validation {
    condition     = contains(["db.r6g.large", "db.r6g.xlarge", "db.r6g.2xlarge"], var.instance_class)
    error_message = "Supported sizes: db.r6g.large, db.r6g.xlarge, db.r6g.2xlarge"
  }
}