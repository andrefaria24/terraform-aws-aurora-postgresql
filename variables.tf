variable "TFE_ORG_NAME" {
  type    = string
  default = "acfaria-hashicorp"
}

variable "db_name" {
  description = "Database Name"
  type        = string
}

variable "db_admin" {
  description = "Database admin username"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
  validation {
    condition     = contains(["us-east-1", "us-east-2", "us-west-1", "us-west-2"], var.region)
    error_message = "Supported regions: us-east-1, us-east-2, us-west-1, us-west-2"
  }
}

variable "instance_class" {
  description = "Instance Size"
  type        = string
  validation {
    condition     = contains(["db.t3.micro"], var.instance_class)
    error_message = "Supported sizes: db.t3.micro"
  }
}