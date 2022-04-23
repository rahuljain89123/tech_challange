provider "aws" {
    region = "${var.aws_region}"
}

terraform {
  backend "s3" {
    bucket = "servians3bucket"
    key    = "terraform-state-rds-service"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "servians3bucket"
    key    = "terraform-state-vpc-service"
    region = "us-east-1"
  }
}


module "rds" {
  source = "./rds"
  vpc_id = "${data.terraform_remote_state.vpc.outputs.vpc_id}"
  public_subnet_ids = "${data.terraform_remote_state.vpc.outputs.public_subnet_ids}"
  private_subnet_ids = "${data.terraform_remote_state.vpc.outputs.private_subnet_ids}"
  instance_security_group = "${data.terraform_remote_state.vpc.outputs.instance_sg_id}"
}


