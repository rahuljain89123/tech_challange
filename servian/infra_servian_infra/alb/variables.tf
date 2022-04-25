variable name {}
variable subnets { type = "list" }
variable internal { default = true }
variable lb_port { default ="443" }
variable lb_protocol { default = "HTTPS"}
variable instance_port { default ="443" }
variable instance_portocol { default = "HTTPS"}
variable security_groups { type = "list" }
variable threshold { default = "2"}
variable unhealthy { default = "2"}
variable timeout { default = "3"}
variable interval { default = "30"}
variable target { default = "HTTPS:/443"}