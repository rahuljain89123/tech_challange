output "vpc_id" {
    value = "${data.terraform_remote_state.vpc.outputs.vpc_id}"
}


output "database_hostname" {
    value = "${module.rds.database_hostname}"
}

output "database_port" {
    value = "${module.rds.database_port}"
}

output "database_username" {
    value = "${module.rds.database_username}"
}

output "database_password" {
    value = "${module.rds.database_password}"
}

output "database_name" {
    value = "${module.rds.database_name}"
}
