variable "region" {
  default = "ap-southeast-2"
  type    = string
}

variable "ami" {
  default = "ami-080785a633a551d87"
  type    = string
}

variable "instance_type" {
  default = "t2.micro"
  type    = string
}

variable "security_group_name" {
  default = "wordpress-security-group"
  type    = string
}