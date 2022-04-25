resource aws_elb elb {
  name  = "${var.name}"
  subnets = [ "${var.subnets}" ]
  internal = "${var.internal}"
  security_group = [ "${var.security_group}" ]

  listerner {
    instance_port = "${var.instance.port}"
    instance_protocol = "${var.instance_portocol}" 
    lb_port = "${var.lb_port}"
    lb_protocol = "${var.lb_protocol}"   
  }

  health_check{

    heatlhy_threshold = "${var.threshold}"
    interval = "${var.interval}"
    target = "${var.target}"
    timeout = "${var.timeout}"
    unhealthy_threhold = "${var.healthy}"
  }
}