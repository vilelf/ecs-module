resource "aws_default_vpc" "default_vpc" {
  
}

resource "aws_default_subnet" "default_subnet_a" {
  availability_zone = format("%sa", var.aws_region)
}

resource "aws_default_subnet" "default_subnet_b" {
  availability_zone = format("%sb", var.aws_region)
}

resource "aws_default_subnet" "default_subnet_c" {
  availability_zone = format("%sc", var.aws_region)
}
