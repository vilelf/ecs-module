# ecs-module

```terraform
#terrafile.tf
provider "aws" {
  region = "us-east-1"
  profile = "mydev"
}

terraform {
  backend "s3" {
    bucket  = "vilelf-tfstates"
    key     = "minimal-django.tfstate"
    region  = "us-east-1"
  }
}

module "ecr" {
  source  = "git@github.com:vilelf/tf-app-django?ref=main"

  ecs_cluster_name = "minimal_django"
  aws_region = "us-east-1"
}

```
