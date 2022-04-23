variable "instance_type" {
  description = "The RDS instance type"
  default     = "db.t2.small"
}

variable "rds_engine" {
  description = "The RDS engine to use"
  default = "postgress"
}

variable "rds_engine_version" {
  default = "10.7"
}

variable "rds_username" {
  description = "The username for the RDS account"
  default = "postgres"
}

variable "rds_password" {
    description = "The password for the RDS account"  
    default="changeme"
}

variable "rds_storage_gigabytes" {
    description = "The amount of RDS storage to provision, in gigabytes"
    default = 30
}

variable "rds_multi_az" {
    description = "The RDS multi-availability zone flag"
    default = false
}

variable "rds_name" {
    description = "Name of the database"
    default = "app"
}

variable "rds_backup_retention_days" {
    description = "RDS backup retention period, in days"
    default = 3
}

variable "vpc_id" {}

variable "public_subnet_ids" {}

variable "private_subnet_ids" {}

variable "instance_security_group" {}
