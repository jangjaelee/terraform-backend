# Terraform backend State Storage and Locking #

This README would normally document whatever steps are necessary to get your application up and running.

These types of resources are supported:

* [S3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)
* [DynamoDB](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table)

## Usage

providers.tf
```hcl
provider "aws" {
  version = ">= 3.2.0"
  region = var.region
  allowed_account_ids = var.account_id
  profile = "eks_service"
}
```

terraform.tf
```hcl
terraform {
  required_version = ">= 0.13.0"
}
```

variables.tf
```hcl
variable "region" {
  description = "AWS Region"
  type        = string
  default     = "ap-northeast-2"
}

variable "account_id" {
  description = "List of Allowed AWS account IDs"
  type        = list(string)
  default     = ["123456789012"]
}

variable "bucket" {
  description = "S3 bucket for terraform-state-backend"
  type        = string
  default     = "kubesphere-terraform-state-backend"
}

variable "dynamodb_table" {
  description = "DynamoDB table for terraform-state-backend"
  type        = string
  default     = "kubesphere-terraform-state-locks"
}

variable "s3_acl" {
  description = "ACL of S3 Bucket"
  type        = string
  default     = "private"
}
```
