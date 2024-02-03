variable "vpc_cidr" {
  default     = "192.168.10.0/24"
}
variable "pub_vpc" {
  default     = "jenkins_vpc"
}
variable "enable_dns_hostnames" {
  default     = "true"
}
variable "enable_dns_support" {
  default     = "true"
}
variable "vpc_gateway" {
  default     = "jenkins_IGW"
}
variable "pub_sub1_cidr" {
  default     = "10.0.1.0/24"
}
variable "pub_sub2_cidr" {
  default     = "10.0.2.0/24"
}
variable "pub_subnet1" {
  default     = "public_subnet1"
}
variable "pub_subnet2" {
  default     = "public_subnet2"
}
variable "map_public_ip_on_launch" {
  default     = "true"
}
variable "pvt_sub1_cidr" {
  default     = "10.0.3.0/24"
}
variable "pvt_sub2_cidr" {
  default     = "10.0.4.0/24"
}
variable "pvt_subnet1" {
  default     = "private_subnet1"
}
variable "pvt_subnet2" {
  default     = "privte_subnet2"
}
variable "pub_route_table1" {
  default     = "public_route_table"
}
variable "pvt_route_table1" {
  default     = "private_route_table"
}
variable "my_sg" {
  default     = "network_security_group"
}
