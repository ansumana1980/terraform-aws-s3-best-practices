# S3 Bucket Module Variables
variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

# Tags to apply to the bucket and related resources
variable "tags" {
  description = "Tags to apply to the bucket"
  type        = map(string)
  default     = {}
}

# Enable versioning
variable "enable_versioning" {
  description = "Enable versioning on the bucket"
  type        = bool
  default     = true
}

# Enable logging
variable "enable_logging" {
  description = "Enable S3 server access logging"
  type        = bool
  default     = false
}

# Logging target bucket
variable "logging_target_bucket" {
  description = "Target bucket for S3 access logs"
  type        = string
  default     = null
}

# Logging target prefix
variable "logging_target_prefix" {
  description = "Prefix for S3 access logs"
  type        = string
  default     = "logs/"
}

# Force destroy
variable "force_destroy" {
  description = "Allow bucket to be destroyed even if it contains objects"
  type        = bool
  default     = true
}

variable "block_public_acls" {
  description = "Block public ACLs for the bucket"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Ignore public ACLs for the bucket"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Block public policies for the bucket"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Restrict public buckets"
  type        = bool
  default     = true
}

variable "enable_encryption" {
  description = "Enable default server-side encryption for the bucket"
  type        = bool
  default     = true
}

variable "sse_algorithm" {
  description = "Server-side encryption algorithm to use"
  type        = string
  default     = "AES256"

  validation {
    condition     = contains(["AES256", "aws:kms"], var.sse_algorithm)
    error_message = "sse_algorithm must be either AES256 or aws:kms."
  }
}

# KMS Master Key ID for aws:kms encryption
variable "kms_master_key_id" {
  description = "Optional KMS Key ID or ARN when using aws:kms encryption"
  type        = string
  default     = null

  validation {
    condition     = var.sse_algorithm != "aws:kms" || (var.kms_master_key_id != null && var.kms_master_key_id != "")
    error_message = "kms_master_key_id must be provided when sse_algorithm is set to aws:kms."
  }
}