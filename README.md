# Terraform modules for provisioning free serverless resource in AWS cloud

## Available Features

Currently below AWS services & resources are supported:
- Lambda with:
  - CloudWatch log group
  - IAM roles and policies
- DynamoDB
- SQS queue
- SNS topic

## Prerequisites

1. Install tools:
   - [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
   - [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
   - [awscurl](https://github.com/okigan/awscurl)
2. [Authenticate with IAM user credentials](https://docs.aws.amazon.com/cli/v1/userguide/cli-authentication-user.html)

## Usage

1. Initialize Terraform:

```bash
cd examples/basic
terraform init
```

2. Prepare file with variables values:

```bash
cp example.tfvars terraform.tfvars
vi terraform.tfvars
```

3. Apply code for infrastructure:

```bash
terraform apply
```

4. Execute Lambda:

```bash
awscurl --service lambda --region us-east-1 --header 'Content-Type: application/json' --header 'Accept: application/json' --data '{"message": "example_post", "key": "118", "transport": "mail"}' "$(terraform output -raw lambda_url_producer)"
```

## Links

* [Serverless Patterns Collection](https://serverlessland.com/patterns?framework=Terraform+%28with+modules%29)
* [Doing serverless with Terraform](https://serverless.tf/)
* [Serverless on AWS](https://aws.amazon.com/serverless/)