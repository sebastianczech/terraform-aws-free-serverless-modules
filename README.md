# Terraform modules for provisioning free serverless resource in AWS cloud

## Available Features

Currently below AWS services & resources are supported:
- IAM roles and policies
- Lambda
- CloudWatch log group
- DynamoDB
- SQS queue
- SNS topic
- S3 bucket

## Usage

### Basic example

```bash
terraform init

terraform apply

awscurl --service lambda --region us-east-1 --header 'Content-Type: application/json' --header 'Accept: application/json' --data '{"message": "example_post", "key": "118", "transport": "mail"}' "$(terraform output -raw lambda_url_producer)"
```
