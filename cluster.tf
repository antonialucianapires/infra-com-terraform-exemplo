resource "aws_security_group" "sg-fc" {
  vpc_id = aws_vpc.vpc-fc.id
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
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

resource "aws_iam_role_policy_attachment" "cluster-eksVpcResourceController" {
  role       = aws_iam_role.role-cluster-fc.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}

resource "aws_iam_role_policy_attachment" "cluster-eksClusterPolicy" {
  role       = aws_iam_role.role-cluster-fc.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_cloudwatch_log_group" "log" {
  name              = "${var.prefix}-${var.cluster_name}"
  retention_in_days = var.retention_days
}

resource "aws_eks_cluster" "cluster" {
  name                      = "${var.prefix}-${var.cluster_name}"
  role_arn                  = aws_iam_role.role-cluster-fc.arn
  enabled_cluster_log_types = ["api", "audit"]
  vpc_config {
    subnet_ids         = aws_subnet.subnets[*].id
    security_group_ids = [aws_security_group.sg-fc.id]
  }
  depends_on = [
    aws_cloudwatch_log_group.log,
    aws_iam_role_policy_attachment.cluster-eksVpcResourceController,
    aws_iam_role_policy_attachment.cluster-eksClusterPolicy
  ]
}
