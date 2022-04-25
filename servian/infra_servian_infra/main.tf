provider "aws" {
    region = "${var.aws_region}"
}

terraform {
  required_version = "~> 0.12"

  backend "s3" {
    encrypt = true
  }
}


data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = var.vpc_service_state_bucket
    key    = var.vpc_service_state_bucket_key
    region = var.aws_region
  }
}

data "terraform_remote_state" "rds" {
  backend = "s3"
  config = {
    bucket = var.vpc_service_state_bucket
    key    = var.vpc_service_rds_state_bucket_key
    region = var.aws_region
  }
}


module "cloudwatch" {
  source = "./cloudwatch"
  deployment_stage = var.deployment_stage
}

module "iam" {
  source = "./iam"
  deployment_stage = var.deployment_stage
  app_log_group_arn = "${module.cloudwatch.app_log_group_arn}"
  ecs_log_group_arn = "${module.cloudwatch.ecs_log_group_arn}"
}

module "ec2" {
  source = "./ec2"

  deployment_stage = var.deployment_stage
  aws_region = "${var.aws_region}"
  key_name = "${var.key_name}"
  ecs_log_level = "${var.ecs_log_level}"
  ecs_cluster_name = "${var.ecs_cluster_name}_${var.deployment_stage}"
  vpc_zone_identifier = "${data.terraform_remote_state.vpc.outputs.vpc_zone_identifier}"
  app_iam_instance_profile_name = "${module.iam.app_iam_instance_profile_name}"
  instance_sg_id = "${data.terraform_remote_state.vpc.outputs.instance_sg_id}"
  ecs_log_group_name = "${module.cloudwatch.ecs_log_group_name}"
}


module "ecs" {
  source = "./ecs"

  deployment_stage = var.deployment_stage
  app_log_group_name = "${module.cloudwatch.app_log_group_name}"
  aws_region = "${var.aws_region}"
  ecs_iam_role_name = "${module.iam.ecs_iam_role_name}"
  # alb_target_group_arn = "${module.alb.alb_target_group_arn}"
  ecs_cluster_name = "${var.ecs_cluster_name}_${var.deployment_stage}"
  ecs_service_iam_role_policy = "${module.iam.ecs_service_iam_role_policy}"
  database_hostname = "${data.terraform_remote_state.rds.outputs.database_hostname}"
  database_port = "${data.terraform_remote_state.rds.outputs.database_port}"
  database_name = "${data.terraform_remote_state.rds.outputs.database_name}"
  database_username = "${data.terraform_remote_state.rds.outputs.database_username}"
  database_password = "${data.terraform_remote_state.rds.outputs.database_password}"
  IMAGE_URL = "${var.IMAGE_URL}"


  #Env variables
  servian_GENERAL_SERVICE_NAME = var.SERVICE_NAME
}

module "alb" {
  source = "./alb"
  
  deployment_stage = var.deployment_stage
  alb_subnets = "${var.subnet}"
  alb_type = "${var.internal}"
  lb_port = "${var.lb_port}"
  lb_protocol = "${var.lb_protocol}"
  instance_port "${var.instance_port}"
  instance_portocol = "${var.instance_portocol}"
  security_groups = "${var.security_groups}"
  threshold = "${var.threshold}"
  unhealthy = "${var.unhealthy}"
  timeout = "${var.timeout}"
  interval = "${var.interval}"
 }



