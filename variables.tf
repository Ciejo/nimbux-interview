variable "region" {
    description = "La region que se utiliza"
}

variable "access_key" {
}

variable "secret_key" {
}
variable "vpc_cidr" {
	description = "VPC"
}

variable "public_cidr" {
    description = "Public-subnet"
    type = list
}

variable "private_cidr" {
    description = "Private-subnet"
    type = list
}

variable "azs" {
    description = "Availability zones"
	type = list
}

variable "ami_nginx" {
    description = "Amazon Linux 2 AMI (HVM)"
}

variable "ami_apache" {
    description = "Ubuntu Server 22.04 LTS "
}

variable "instance_type" {
    description = "Instance type"
}

