/*You should never store your state file locally, especially when working in a team or managing production infrastructure. 
Instead, use a remote backend like AWS S3 to securely store and manage your Terraform state file. 
This allows for better collaboration, state locking, and versioning, ensuring that your infrastructure is managed safely and efficiently.
For AWS, this means using an S3 bucket to store the state file and optionally using DynamoDB for state locking to prevent concurrent modifications.
*/


# Set up the S3 backend for Terraform state management
terraform {
  backend "s3" {
    bucket         = "ansumana1980-terraform-state-east1-20260331" # Replace with your S3 bucket name
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks" # Replace with your DynamoDB table name for state locking
  }
}


