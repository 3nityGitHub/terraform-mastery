 
#Talium-Tech Production Infrastructure (Terraform)

Overview
This repository contains the production ready AWS infrastructure for the Talium-Tech Care Management Platform. All resources are provisioned using Terraform, fully modular, secure, and aligned with best practices.
The infrastructure includes:
•	VPC with public + private subnets across 2 AZs
•	NAT gateways for private outbound traffic
•	Security groups with strict SG to SG rules
•	RDS PostgreSQL (encrypted, Multi AZ, private only)
•	SSM Parameter Store for secrets
•	Remote Terraform state with locking
•	Consistent tagging across all resources
This stack is designed to be the foundation for deploying the Talium application (API, workers, ALB, etc.).
 
Architecture Diagram (Text Version)
                    Internet
                        |
                 +--------------+
                 |     ALB      |
                 |   (Public)   |
                 +--------------+
                        |
                +----------------+
                |   App SG       |
                | (Private App)  |
                +----------------+
                        |
                +----------------+
                |   RDS SG       |
                | (Private DB)   |
                +----------------+
Subnets:
•	Public Subnets (2 AZs)
→ ALB, NAT Gateways
•	Private App Subnets (2 AZs)
→ Application workloads
•	Private DB Subnets (2 AZs)
→ RDS PostgreSQL
 
Folder Structure
day7/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── README.md
└── modules/
    ├── vpc/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── security-groups/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── rds/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
 
Prerequisites
Before deploying, ensure you have:
•	AWS CLI configured (aws configure)
•	Terraform v1.5+ installed
•	S3 bucket + DynamoDB table created for remote state:
aws s3 mb s3://talium-terraform-state --region eu-west-2
aws dynamodb create-table \
  --table-name talium-terraform-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region eu-west-2
 
How to Deploy
1. Initialize Terraform
terraform init
2. Validate configuration
terraform validate
3. Preview changes
terraform plan
4. Apply infrastructure
terraform apply
Type yes when prompted.
 
How to Verify Deployment
VPC
aws ec2 describe-vpcs --filters "Name=tag:Name,Values=talium-prod-vpc"
Subnets
aws ec2 describe-subnets --filters "Name=vpc-id,Values=<vpc-id>"
Security Groups
aws ec2 describe-security-groups --group-ids <sg-id>
RDS
aws rds describe-db-instances --db-instance-identifier talium-prod-postgres
SSM Parameter
aws ssm get-parameter --name /talium/prod/db/password --with-decryption
 
How to Destroy
terraform destroy
This will remove all infrastructure except:
•	S3 backend bucket
•	DynamoDB lock table
These must be deleted manually.
 
Security Considerations
•	No secrets are stored in Git
•	DB password stored in SSM SecureString
•	RDS is private-only, not publicly accessible
•	SG to SG rules enforce least privilege
•	Encryption enabled for RDS and S3 state
•	Deletion protection enabled on RDS
 
Notes for Engineers
•	Application workloads should be deployed into private app subnets
•	ALB should be deployed into public subnets
•	Use the outputs in terraform output to configure CI/CD
•	DB password must be retrieved from SSM at runtime
 


