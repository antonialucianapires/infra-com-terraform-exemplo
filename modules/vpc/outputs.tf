output "vpc_id" {
  value = aws_vpc.vpc-fc.id
}

output "subnet_ids" {
  value = aws_subnet.subnets[*].id
}