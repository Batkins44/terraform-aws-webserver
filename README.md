# Terraform AWS Web Server

Infrastructure as Code project that provisions a web server on AWS using Terraform. Part of a hands-on DevOps learning path — this is **Tier 2: Infrastructure as Code**.

## What It Does

With a single command, this project:

- Provisions a **free-tier EC2 instance** (t3.micro) running Amazon Linux 2023
- Creates a **security group** allowing inbound HTTP traffic on port 80
- Installs and starts **Apache (httpd)** via a boot script
- Outputs the **public IP** so you can visit the site immediately

The entire environment can be destroyed and recreated in under two minutes.

## Architecture

```
Internet
   │
   ▼ (port 80)
┌──────────────────────┐
│  Security Group      │
│  - Inbound: HTTP 80  │
│  - Outbound: All     │
├──────────────────────┤
│  EC2 Instance        │
│  - Amazon Linux 2023 │
│  - t3.micro          │
│  - Apache (httpd)    │
└──────────────────────┘
```

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) installed
- [AWS CLI](https://aws.amazon.com/cli/) configured with credentials (`aws configure`)
- An AWS account with free-tier eligibility

## Usage

```bash
# Initialize Terraform (downloads AWS provider)
terraform init

# Preview what will be created
terraform plan

# Create the infrastructure
terraform apply

# Visit the outputted public IP in your browser
# http://<public_ip>

# Tear it all down
terraform destroy
```

## Project Structure

```
.
├── main.tf          # Provider config, security group, and EC2 instance
├── outputs.tf       # Outputs the public IP after apply
└── .gitignore       # Excludes Terraform state and local files
```

## Key Concepts Demonstrated

- **Declarative infrastructure** — define what you want, Terraform figures out how
- **Idempotency** — running `apply` again changes nothing if the state matches
- **Reproducibility** — destroy and rebuild an identical environment at will
- **State management** — Terraform tracks what it created in `terraform.tfstate`

## Part of a DevOps Learning Path

| Tier | Focus | Status |
|------|-------|--------|
| 1 | Containerization (Docker) | [Complete](https://github.com/Batkins44/jellyfin-docker) |
| 2 | Infrastructure as Code (Terraform + AWS) | **This project** |
| 3 | CI/CD (GitHub Actions) | Up next |
| 4 | Configuration Management (Ansible) | Planned |
| 5 | Full Pipeline (all combined) | Planned |
