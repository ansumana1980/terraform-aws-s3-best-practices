# 🛠️ Backend AWS CLI Setup

## 📌 Overview

Terraform state should **never be stored locally** when working in team or production environments.
Instead, use a **remote backend** to ensure:

* Secure state storage
* Version control
* Collaboration safety
* State locking to prevent concurrent changes

For AWS, this is achieved using:

* **Amazon S3** → stores the Terraform state file
* **DynamoDB** → provides state locking

---

## 🚀 Step 1: Create Backend Resources (One-Time Setup)

Before running `terraform init`, create the required backend resources using AWS CLI.

### ✅ Create S3 Bucket for State

```bash
aws s3api create-bucket --bucket <YOUR-BUCKET-NAME> --region <YOUR REGION>
```

aws s3api delete-bucket --bucket <YOUR-BUCKET-NAME> --region <YOUR REGION>

> ⚠️ Bucket name must be globally unique

---

### ✅ Enable Versioning (Highly Recommended)

```bash
aws s3api put-bucket-versioning --bucket <YOUR-BUCKET-NAME>  --versioning-configuration Status=Enabled

---

### ✅ Create DynamoDB Table for State Locking

```bash
aws dynamodb create-table \
  --table-name terraform-state-lock \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region us-east-1
```

aws dynamodb create-table \
  --table-name terraform-state-lock \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region us-east-1 \
  --no-cli-pager

🧨 Delete DynamoDB table (Terraform lock table
aws dynamodb delete-table --table-name terraform-state-lock --region us-east-1

🔍 Verify it’s deleted
Verify it’s deleted
aws dynamodb list-tables --region us-east-1

## ⚙️ Step 2: Configure Terraform Backend

Create a `backend.tf` file:

```hcl
terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket-name" # replace bucket with unique name
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}
```

---

## 🔐 Backend Benefits

* Prevents multiple users from running `terraform apply` simultaneously
* Protects infrastructure state from corruption
* Enables version recovery
* Improves team collaboration

---

## 🧪 Useful AWS CLI Commands (Validation)

### List Objects in Log Bucket

```bash
aws s3 ls s3://your-log-bucket-name/ --recursive
```

### Check Bucket Policy

```bash
aws s3api get-bucket-policy --bucket your-log-bucket-name
```

### Verify Logging Configuration

```bash
aws s3api get-bucket-logging --bucket example-1
aws s3api get-bucket-logging --bucket example-2
aws s3api get-bucket-logging --bucket example-3
```

---

## ⚠️ Important Notes

* Backend resources must exist **before running `terraform init`**
* Backend configuration **cannot use variables or `terraform.tfvars`**
* Always enable **versioning** on the state bucket
* Never commit sensitive backend values to public repositories

---

## 💼 Best Practice Summary

* Use S3 for remote state
* Enable encryption and versioning
* Use DynamoDB for locking
* Keep backend config simple and secure
* Validate setup with AWS CLI

