locals {
  prefix = "market-pulse"
}

resource "aws_vpc" "main_vpc" {
  cidr_block = "10.10.0.0/16"
}

resource "aws_subnet" "market_pulse_sbnt_public" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.10.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-north-1a"
  tags = {
    Name = "public"
  }
}

resource "aws_subnet" "market_pulse_sbnt_private" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.10.2.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "eu-north-1a"
  tags = {
    Name = "private"
  }
}

resource "aws_internet_gateway" "gateway_main" {
  vpc_id = aws_vpc.main_vpc.id
}

resource "aws_route_table" "route_public" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway_main.id
  }
}

resource "aws_route_table_association" "public_subnet_route" {
  route_table_id = aws_route_table.route_public.id
  subnet_id      = aws_subnet.market_pulse_sbnt_public.id
}

resource "aws_security_group" "sg_private" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "private"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress_private" {
  security_group_id = aws_security_group.sg_private.id

  referenced_security_group_id = aws_security_group.sg_public.id
  ip_protocol                  = "tcp"
  from_port                    = 22
  to_port                      = 22
}

resource "aws_vpc_security_group_egress_rule" "egress_private" {
  security_group_id = aws_security_group.sg_private.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_security_group" "sg_public" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "public"
  }
}

resource "aws_vpc_security_group_ingress_rule" "igress_public" {
  security_group_id = aws_security_group.sg_public.id
  cidr_ipv4         = var.public_ip_ssh
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "egress_public" {
  security_group_id = aws_security_group.sg_public.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}