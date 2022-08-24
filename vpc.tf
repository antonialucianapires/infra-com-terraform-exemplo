resource "aws_vpc" "vpc-fc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "vpc-fc"
  }
}

resource "aws_subnet" "fc-subnet-1" {
  availability_zone = "us-east-1d"
  vpc_id = aws_vpc.vpc-fc.id
  cidr_block = "10.0.0.0/24"
  tags = {
    "Name" = "fcsubnet-1"
  }
}

resource "aws_subnet" "fc-subnet-2" {
  availability_zone = "us-east-1a"
  vpc_id = aws_vpc.vpc-fc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    "Name" = "fcsubnet-2"
  }
}
