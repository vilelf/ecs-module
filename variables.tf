variable "ecr_repo_name" {
  type        = string
  default     = false
  description = "Nome do repositorio ECR que será criado"
}

variable "ecs_cluster_name" {
  type        = string
  default     = false
  description = "Nome do cluster ECS que será criado"
}

variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "Região na AWS onde ficará nossa infra"
}

variable "subdomain_name" {
  type        = string
  default     = false
  description = "Subdominio"
}

variable "zone_id" {
  type        = string
  default     = false
  description = "Zona onde vai estar nosso domínio"
}