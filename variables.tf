variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}

variable "log_bucket_name" {
  description = "Name of the S3 access log bucket"
  type        = string
}

variable "s3_bucket_names" {
  description = "Set of S3 bucket names to create"
  type        = set(string)
}

variable "enable_versioning" {
  description = "Enable versioning on buckets"
  type        = bool
}

variable "enable_encryption" {
  description = "Enable bucket encryption"
  type        = bool
}

variable "sse_algorithm" {
  description = "Server-side encryption algorithm"
  type        = string
}

variable "kms_master_key_id" {
  description = "KMS key ARN or ID when using aws:kms"
  type        = string
  default     = null
}