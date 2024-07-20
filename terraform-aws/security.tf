resource "aws_vpc" "vpc_devops" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "DevOps project VPC"
  }
}

resource "aws_security_group" "allow_ec2" {
  vpc_id      = aws_vpc.vpc_devops.id
  name        = "allow_ec2"
  description = "Allow traffic on EC2 instance"

  tags = {
    Name = "allow_ec2"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_traffic_my_ip_ssh" {
  security_group_id = aws_security_group.allow_ec2.id
  cidr_ipv4         = var.my_ip
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_traffic_my_ip_app" {
  security_group_id = aws_security_group.allow_ec2.id
  cidr_ipv4         = var.my_ip
  from_port         = 3000
  ip_protocol       = "tcp"
  to_port           = 30000
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_ec2.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_subnet" "subnet_devops" {
  vpc_id            = aws_vpc.vpc_devops.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "${var.location}a"

  tags = {
    "Name" = "public-subnet-1"
  }
}

resource "aws_route_table" "route_table_devops" {
  vpc_id = aws_vpc.vpc_devops.id

  tags = {
    "Name" = "route-table-1"
  }
}

resource "aws_route_table_association" "route_table_assoc_devops" {
  subnet_id      = aws_subnet.subnet_devops.id
  route_table_id = aws_route_table.route_table_devops.id
}

resource "aws_internet_gateway" "internet_gateway_devops" {
  vpc_id = aws_vpc.vpc_devops.id

  tags = {
    "Name" = "gateway-devops"
  }
}

resource "aws_route" "internet-route" {
  destination_cidr_block = "0.0.0.0/0" # default route
  route_table_id         = aws_route_table.route_table_devops.id
  gateway_id             = aws_internet_gateway.internet_gateway_devops.id
}