data "aws_availability_zones" "available" {}

resource "aws_vpc" "primary_vpc" {
  cidr_block = "${var.vpc_cidr_block}"
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-services-${var.deployment_stage}"
  }

}

resource "aws_subnet" "public" {
  count = "${var.az_count}"
  cidr_block = "${cidrsubnet(aws_vpc.primary_vpc.cidr_block, 8, count.index)}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  vpc_id            = "${aws_vpc.primary_vpc.id}"
  tags = {
    Name = "Public Subnet-vpc-services-${var.deployment_stage}"  
  }
}

# Create var.az_count private subnets, each in a different AZ
resource "aws_subnet" "private" {
  count             = "${var.az_count}"
  cidr_block        = cidrsubnet(aws_vpc.primary_vpc.cidr_block, 8, var.az_count + count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id            = "${aws_vpc.primary_vpc.id}"
  tags = {
    Name = "Private Subnet-vpc-services-${var.deployment_stage}"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.primary_vpc.id}"
  tags = {
    Name = "vpc-services-${var.deployment_stage}"
  }
}

resource "aws_route_table" "main" {
  vpc_id = "${aws_vpc.primary_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

}

resource "aws_route_table_association" "main" {
  count          = "${var.availability_zone_count}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.main.id}"
}


resource "aws_security_group" "alb_sg" {
  description = "The security group used to grant access to the ALB"

  vpc_id = "${aws_vpc.primary_vpc.id}"

  # ingress {
  #   protocol    = "tcp"
  #   from_port   = 80
  #   to_port     = 80
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}

resource "aws_security_group" "instance_sg" {
  description = "The security group allowing SSH administrative access to the instances"
  vpc_id      = "${aws_vpc.primary_vpc.id}"

  ingress {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22

    cidr_blocks = [
      "${var.admin_cidr_ingress}",
    ]
  }

  ingress {
    protocol  = "tcp"
    from_port = 32768
    to_port   = 61000

    security_groups = [
      "${aws_security_group.alb_sg.id}",
    ]
  }

  egress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = "${aws_subnet.private.*.cidr_block}"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vpc-services-${var.deployment_stage}"
  }
  
}



data "aws_route53_zone" "internal_zone" {
  name = var.stage_internal_hosted_zone_name
  private_zone = true
}

resource "aws_route53_zone_association" "secondary" {
  zone_id = data.aws_route53_zone.internal_zone.id
  vpc_id  = aws_vpc.primary_vpc.id
}
