variable "prefix" {
  description = "prefixo para nome dos recursos"
}

variable "cluster_name" {
  description = "nome do cluster"
}

variable "retention_days" {
  description = "total de dias de retenção de logs"
}

variable "desired_size" {}
variable "max_size" {}
variable "min_size" {}
