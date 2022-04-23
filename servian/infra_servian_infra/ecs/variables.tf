variable "ecs_desired_instances" {
  description = "The desired number of instances for ECS"
  default     = "2"
}

variable "container_name" {
  description = "The name of the ECS container"
  default = "app"
}

variable "IMAGE_URL" {}

variable "docker_container_port" {
  description = "The Docker container port"
  default = 3000
}

variable "docker_host_port" {
  description = "The Docker host port"
  default = 0
}

variable "ecs_cluster_name" {}

variable "ecs_task_family" {
  description = "The ECS task family name"
  default = "goapp_service_task_family"
}

variable "deployment_stage" {}

variable "app_log_group_name" {}

variable "aws_region" {}

variable "ecs_iam_role_name" {}

variable "ecs_service_iam_role_policy" {}

variable "database_hostname" {}

variable "database_port" {}

variable "database_name" {}

variable "database_username" {}

variable "database_password" {}

variable "SERVICE_NAME" {}