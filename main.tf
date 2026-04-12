/* This Terraform configuration sets up an S3 bucket for access logs and multiple S3 buckets with logging enabled. 
The log bucket is configured to allow the S3 logging service to write access logs, 
and each of the specified S3 buckets will send their access logs to the log bucket with a specific prefix.
*/

data "aws_caller_identity" "current" {}

module "log_bucket" {
  source = "../modules/s3_bucket"

  bucket_name       = var.log_bucket_name
  tags              = var.tags
  enable_logging    = false
  enable_versioning = var.enable_versioning
  enable_encryption = var.enable_encryption
  sse_algorithm     = var.sse_algorithm
  kms_master_key_id = var.kms_master_key_id
  force_destroy     = var.environment != "prod"
}

module "s3_buckets" {
  source = "./modules/s3_bucket"

  for_each = var.s3_bucket_names

  bucket_name           = each.value
  tags                  = var.tags
  enable_versioning     = var.enable_versioning
  enable_logging        = true
  logging_target_bucket = module.log_bucket.bucket_name
  logging_target_prefix = "${each.value}/"
  enable_encryption     = var.enable_encryption
  sse_algorithm         = var.sse_algorithm
  kms_master_key_id     = var.kms_master_key_id
  force_destroy         = var.environment != "prod"
}

resource "aws_s3_bucket_policy" "log_bucket_policy" {
  bucket = module.log_bucket.bucket_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "S3ServerAccessLogsPolicy"
        Effect = "Allow"

        Principal = {
          Service = "logging.s3.amazonaws.com"
        }

        Action   = "s3:PutObject"
        Resource = "${module.log_bucket.bucket_arn}/*"

        Condition = {
          StringEquals = {
            "aws:SourceAccount" = data.aws_caller_identity.current.account_id
          }
        }
      }
    ]
  })
}