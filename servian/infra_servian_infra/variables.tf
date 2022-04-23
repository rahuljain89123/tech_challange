variable "aws_region" {
  description = "The AWS region for creating the infrastructure"
}

variable "key_name" {
  description = "Name of the AWS key pair to use"
  default = "ec2-demo-server"
}

variable "ecs_cluster_name" {
  default = "configureservice_ecs_cluster"
}

variable "ecs_log_level" {
  description = "The ECS log level"
  default = "info"
}

variable "admin_cidr_ingress" {
  default= "0.0.0.0/0"
}

variable "public_dns_name" {
  description = "The public-facing DNS name"

}


variable "service_name" {
  description = "service name"
}

variable "zone_name" {
  description = "The DNS zone name"
}

variable deployment_stage {}

variable "vpc_service_state_bucket" {}

variable "vpc_service_state_bucket_key" {}

variable "vpc_service_rds_state_bucket_key" {}

variable "IMAGE_URL" {}

