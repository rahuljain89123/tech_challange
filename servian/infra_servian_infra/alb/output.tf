output elb_id {
  value = "${aws_elb.elb.id}"
}

output elb_arn {
  value = "${aws_elb.elb.arn}"
}

output elb_dns_name {
  value = "${aws_elb.elb.dns_name}"
}

output elb_zone_id {
  value = "${aws_elb.elb.zone_id}"
}