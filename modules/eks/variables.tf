variable "vpc_id" {
  description = "id da vpc"
}

variable "prefix" {
  description = "prefixo para nome dos recursos"
}

variable "cluster_name" {
  description = "nome do cluster"
}

variable "retention_days" {
  description = "total de dias de retenção de logs"
}

variable "subnet_ids" {
  description = "ids das subnets"
}

variable "desired_size" {}
variable "max_size" {}
variable "min_size" {}
