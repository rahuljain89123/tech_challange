resource "aws_ecs_cluster" "main" {
  name = "${var.ecs_cluster_name}"
}

data "template_file" "task_definition" {
  template = "${file("${path.module}/templates/task-definition.tpl")}"

  vars = {
    family           = "${var.ecs_task_family}_${var.deployment_stage}"
    IMAGE_URL        = "${var.IMAGE_URL}"
    container_name   = "${var.container_name}"
    log_group_region = "${var.aws_region}"
    log_group_name   = "${var.app_log_group_name}"
    container_port   = "${var.docker_container_port}"
    host_port        = "${var.docker_host_port}"
    database_hostname = "${var.database_hostname}"
    database_port     = "${var.database_port}"
    database_name     = "${var.database_name}"
    database_username = "${var.database_username}"
    database_password = "${var.database_password}"

    #Env variables
    servian_GENERAL_SERVICE_NAME = var.SERVICE_NAME
  
  }
}

resource "aws_ecs_task_definition" "main" {
  family                = "${var.ecs_task_family}_${var.deployment_stage}"
  container_definitions = "${data.template_file.task_definition.rendered}"
}

resource "aws_ecs_service" "main" {
  name            = "ecs_service_${var.deployment_stage}"
  cluster         = "${aws_ecs_cluster.main.id}"
  task_definition = "${aws_ecs_task_definition.main.arn}"
  desired_count   = "${var.ecs_desired_instances}"
}
