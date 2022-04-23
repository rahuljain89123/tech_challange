variable "availability_zone_count" {
  description = "The number of availability zones to be leveraged within the VPC"
  default     = "2"
}


variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "2"
}

variable "private_subnet_cidr_block" {
  description = "The CIDR block for the private subnet within the VPC"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
}

variable "public_subnet_cidr_block" {
  description = "The CIDR block for the public subnet within the VPC"
}
variable "deployment_stage" {}


variable "stage_internal_hosted_zone_name" {}
