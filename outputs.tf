/* This Terraform configuration defines outputs for S3 bucket information, including bucket IDs, ARNs, and names.
It uses a for_each loop to iterate over the S3 buckets created by the module and outputs the 
relevant information in a structured format. */


# Bucket IDs
output "bucket_ids" {
  description = "Map of bucket keys to S3 bucket IDs"
  value = {
    for name, bucket in module.s3_buckets : name => bucket.bucket_id
  }
}

# Bucket ARNs
output "bucket_arns" {
  description = "Map of bucket keys to S3 bucket ARNs"
  value = {
    for name, bucket in module.s3_buckets : name => bucket.bucket_arn
  }
}

# Bucket Names
output "bucket_names" {
  description = "Map of bucket keys to S3 bucket names"
  value = {
    for name, bucket in module.s3_buckets : name => bucket.bucket_name
  }
}