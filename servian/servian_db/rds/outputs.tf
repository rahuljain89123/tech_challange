output "database_hostname" {
    value = "${aws_db_instance.postgressdb.address}"
}

output "database_port" {
    value = "${aws_db_instance.postgressdb.port}"
}

output "database_username" {
    value = "${var.rds_username}"
}

output "database_password" {
    value = "${var.rds_password}"
}

output "database_name" {
    value = "${aws_db_instance.postgressdb.name}"
}