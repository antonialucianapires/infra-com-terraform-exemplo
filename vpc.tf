resource "aws_vpc" "vpc-fc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "vpc-${var.prefix}"
  }
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "subnets" {
  count                   = 2
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  vpc_id                  = aws_vpc.vpc-fc.id
  cidr_block              = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "${var.prefix}-subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "fc-igw" {
  vpc_id = aws_vpc.vpc-fc.id
  tags = {
    "Name" = "${var.prefix}-igw"
  }
}

resource "aws_route_table" "fc-rt" {
  vpc_id = aws_vpc.vpc-fc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.fc-igw.id
  }

  tags = {
    Name = "${var.prefix}-rt"
  }
}
