resource "aws_vpc" "jnk_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  instance_tenancy     = "default"

  tags = {
    Name = var.pub_vpc
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.jnk_vpc.id

  tags = {
    Name = var.vpc_gateway
  }
} 
resource "aws_subnet" "pub_sub1" {
  vpc_id                  = aws_vpc.jnk_vpc.id
  cidr_block              = var.pub_sub1_cidr
  availability_zone       = data.aws_availability_zones.az.names[0] 
  map_public_ip_on_launch = var.map_public_ip_on_launch 
  tags = {
    Name = var.pub_subnet1
  }

}
resource "aws_subnet" "pub_sub2" {
  vpc_id                  = aws_vpc.new_vpc.id
  cidr_block              = var.pub_sub2_cidr
  availability_zone       = data.aws_availability_zones.az.names[1]
  map_public_ip_on_launch = var.map_public_ip_on_launch ### auto asign ip ## True 

  tags = {
    Name = var.pub_subnet2
  }
}
## Minimum two private subnet create use for load balancer and auto scaling in different AZ ###
## Private subnet use for Data base server like my SQL

resource "aws_subnet" "pvt_sub1" {
  vpc_id                  = aws_vpc.new_vpc.id
  cidr_block              = var.pvt_sub1_cidr
  availability_zone       = data.aws_availability_zones.az.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = var.pvt_subnet1
  }
}
resource "aws_subnet" "pvt_sub2" {
  vpc_id                  = aws_vpc.new_vpc.id
  cidr_block              = var.pvt_sub2_cidr
  availability_zone       = data.aws_availability_zones.az.names[1]
  map_public_ip_on_launch = false
  tags = {
    Name = var.pvt_subnet2
  }
}
## ROUTE CREATE / ROUTE TABLE / subnet Association FOR TWO PUBLIC SUBNET ##

resource "aws_route_table" "pub_route_table" {
  vpc_id = aws_vpc.new_vpc.id
  tags = {
    Name = var.pub_route_table1
}
}
resource "aws_route" "pub_route" {
  route_table_id         = aws_route_table.pub_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
resource "aws_route_table_association" "pub_sub1_association" {
  subnet_id      = aws_subnet.pub_sub1.id
  route_table_id = aws_route_table.pub_route_table.id
}
resource "aws_route_table_association" "pub_sub2_association" {
  subnet_id      = aws_subnet.pub_sub2.id
  route_table_id = aws_route_table.pub_route_table.id
}
## ROUTE CREATE / ROUTE TABLE / subnet Association FOR TWO PUBLIC SUBNET ##

resource "aws_route_table" "pvt_route_table" {
  vpc_id = aws_vpc.new_vpc.id
  tags = {
    Name = var.pvt_route_table1
  }
}
resource "aws_route_table_association" "pvt_sub1_association" {
  subnet_id      = aws_subnet.pvt_sub1.id
  route_table_id = aws_route_table.pvt_route_table.id
}
resource "aws_route_table_association" "pvt_sub2_association" {
  subnet_id      = aws_subnet.pvt_sub2.id
  route_table_id = aws_route_table.pvt_route_table.id
}
######## Security Group ############

resource "aws_security_group" "sg" {
  name        = "vpc_security_group"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.new_vpc.id

  ingress { ## inbound rule
    description = "all traffic from VPC"
    from_port   = 0    #all port
    to_port     = 0    #all port
    protocol    = "-1" #all traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress { ## outbound rule             
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.my_sg
  }
}
