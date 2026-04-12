# 📦 Terraform AWS S3 Secure Buckets Project

## 📌 Overview

This project demonstrates how to provision and manage multiple secure Amazon S3 buckets using **Terraform** and Infrastructure as Code (IaC) best practices.

The solution uses a **modular, data-driven design** to dynamically create multiple S3 buckets with centralized logging, encryption, and secure configurations—simulating a **production-ready cloud environment**.

---

## 🎯 Objective

To showcase how cloud engineers can:

* Automate infrastructure using Terraform
* Build reusable modules
* Enforce security and compliance by default
* Scale resource creation using dynamic constructs like `for_each`

---

## 🏗️ Architecture

![Image](https://images.openai.com/static-rsc-4/0k5YbMrHCcsscvYxEhFGK1Ll7MDSHZ9VbAP0NEV6nasqMdFPdQe9b4w4idMousyjmVrsAr8LPfF6dnRF7mv54M-0xz817FiEvS89muZRtWKaAl9k9Y7pHy1RpJcgGek5Uqr31WtwgmwDJ1J17PwyvL5Rygz-3RtB71EZBVl3ZSHxcEURvRzyoKKsx1KADB_2?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/w72cF_vLTqqwvkclAsSv3n0AzyWZwB7JkG-A5y1djubczLRI-rs4GvCkhvcBAjLpmB3oGSpJ24g5basFwfPV0mR5dx-pinqu90RLw_vlCfW2va4gcduKwPXVLfzx6T3rmX6FJRZ16xmsCUHyW97AdvHd2i3P_z94yn2udylY9Lnjz0h1Gqj6VcgoROfCjpj6?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/Ulo2oa_x4yEu77p2Oussie0dwuH6nOdBcinchNtqzp1a-Rg5ZcaktfcFDcSdP8eHxsivveLwqfHyQ4BvZFWiungqXtijGCJ73rzwhCmtGN8PJY9a8-JOWvx4e0sP315MBRPyfoT-m315piBJ6DdZEZ_NHIuc_mtNMrhew3DYJmoMd55PV59zY9Z4RrWvADAv?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/XUTqPz5pGCGAYpf8-Ozuc5EggfefZJhrhTBH8LVnv3o1kYhZcO2U1pQcwiqBsl8BnzfUXr9k_rLBeSZQOULJDK_FdtwSAJedZfkNz6P6SZN2VH8pyFNSy6m6PjGaq4OKX_O8n2Iw6gCu5sTGJbVm12__gbhZcqCXMaRVtmohb33OQO695VEaUxWRs5dpx170?purpose=fullsize)

![Image](https://images.openai.com/static-rsc-4/vPBEdWj5QKVwVHCdjSqXMGG5YSRNYaLR19gP-nk0ML-3EsVMm9zznLQHpDv4NuF3dcsnauLcF2dLaiNIH5g5h6GWM4D3sndKC_hLIH20DPAHp_PFBlkNnz1Q2MDf7PQuY9ctAvrGvDfBxrt2w1veyCjAjFH70FNHndnM0akxNYwJelZuHlioadT55qAE2kQq?purpose=fullsize)

### 🔄 Flow

1. Terraform state is stored in an **S3 backend**
2. **DynamoDB** is used for state locking
3. A dedicated **log bucket** collects access logs
4. Multiple S3 buckets send logs to the log bucket
5. Buckets are secured with:

   * Public access block
   * Server-side encryption (AES256 or KMS)
   * Versioning

---

## ⚙️ What Was Built

### ✅ Remote State Management

* Configured S3 backend for Terraform state
* Enabled state encryption
* Designed for DynamoDB locking (recommended for team environments)

---

### ✅ Reusable S3 Module

* Built modular S3 component (`modules/s3_bucket`)

* Parameterized inputs:

  * bucket name
  * tags
  * encryption settings
  * logging configuration

* Features:

  * Versioning
  * Server-side encryption (AES256 / KMS)
  * Public access blocking
  * Optional logging

---

### ✅ Dynamic Multi-Bucket Provisioning

* Used `for_each` to create multiple buckets:

  * accounting
  * asset
  * finance
* Eliminated repetitive code using variables

---

### ✅ Centralized Logging Architecture

* Dedicated log bucket
* All buckets send access logs to one location
* Dynamic prefixes per bucket for organization

---

### ✅ Security & Compliance

* Blocked all public access
* Enforced encryption at rest
* Implemented least-privilege logging policy
* Scoped permissions using `aws_caller_identity`

---

### ✅ Outputs & Observability

* Exposed:

  * bucket IDs
  * ARNs
  * names
* Structured outputs for integration and validation

---

## ⚙️ Terraform Workflow

```bash
terraform fmt
terraform validate
terraform plan
terraform apply
```

---

## 🔍 Validation & Testing

```bash
aws s3 ls
```

```bash
aws s3api get-bucket-logging --bucket <bucket-name>
```

```bash
aws s3api get-bucket-policy --bucket <log-bucket>
```

✔️ Verified:

* Buckets created successfully
* Logging configured correctly
* Permissions applied properly
* Logs delivered (with expected delay)

---

## 🧠 Key Learnings

* Terraform modules require explicit variable definitions
* Output names must match exactly across modules
* S3 bucket names must be globally unique
* Remote state buckets must exist before `terraform init`
* S3 logging requires explicit bucket policies
* Logging delivery is asynchronous

---

## ⭐ Best Practices Implemented

* Modular Terraform architecture
* Separation of configuration using `terraform.tfvars`
* Centralized logging for auditability
* Secure-by-default S3 configuration
* Environment-aware logic (e.g., `force_destroy`)
* Clean and scalable project structure

---

## 📁 Project Structure

```text
terraform-aws-s3-best-practices/
├── README.md
├── backend.tf
├── providers.tf
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars.example
├── .gitignore
│
├── docs/
│   ├── backend-setup.md
│   └── build-guide.md
│
├── modules/
│   └── s3_bucket/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
```

---

## 🚀 Future Enhancements

* Add lifecycle policies (cost optimization)
* Implement cross-region replication (DR strategy)
* Integrate CI/CD (GitHub Actions / Jenkins)
* Add IAM role-based access controls per bucket

---

## 💼 Portfolio Value

This project demonstrates:

* Terraform (modules, variables, outputs, backends)
* AWS S3 architecture design
* Secure infrastructure design principles
* DevOps best practices (state, locking, modularity)
* Real-world problem-solving and debugging

