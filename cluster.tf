resource "aws_security_group" "sg-fc" {
  vpc_id = aws_vpc.vpc-fc.id
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    prefix_list_ids = []
  }
  tags = {
    "Name" = "${var.prefix}-sg"
  }
}
