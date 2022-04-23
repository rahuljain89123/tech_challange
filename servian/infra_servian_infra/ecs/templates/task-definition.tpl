[
    {
        "memory":1024,
        "networkMode":"awsvpc",
        "cpu":512,
        "family": "${family}",
        "portMappings": [
            {
                "hostPort": ${host_port},
                "containerPort": ${container_port},
                "protocol": "tcp"
            }
        ],
        "essential": true,
        "name": "${container_name}",
        "image": "${IMAGE_URL}",
        "environment" : [
            { "name" : "servian_GENERAL_DATABASE_HOST", "value" : "${database_hostname}" },
            { "name" : "servian_GENERAL_DATABASE_USER", "value" : "${database_username}" },
            { "name" : "servian_GENERAL_DATABASE_PASSWORD", "value" : "${database_password}" },
            { "name" : "servian_GENERAL_SERVICE_NAME", "value" : "${servian_GENERAL_SERVICE_NAME}" },
            { "name" : "servian_GENERAL_DATABASE_NAME", "value" : "${database_name}" }
        ],
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-group": "${log_group_name}",
                "awslogs-region": "${log_group_region}"
            }
        }
    }

]
