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

resource "aws_iam_role" "role-cluster-fc" {
  name               = "${var.prefix}-${var.cluster_name}-role"
  assume_role_policy = <<POLICY
    {
       "Version": "2012-10-17",
       "Statement": [
            {
                "Effect": "Allow",
                "Principal": {
                    "Service": "eks.amazonaws.com"
                },
                "Action": "sts:AssumeRole"
            }
       ] 
    }
  POLICY
}
