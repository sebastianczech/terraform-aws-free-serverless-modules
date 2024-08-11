# DynamoDB

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.61 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.61 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name of the DynamoDB table | `string` | n/a | yes |
| <a name="input_read_capacity"></a> [read\_capacity](#input\_read\_capacity) | The read capacity of the DynamoDB table | `number` | `1` | no |
| <a name="input_write_capacity"></a> [write\_capacity](#input\_write\_capacity) | The write capacity of the DynamoDB table | `number` | `1` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the DynamoDB table |
| <a name="output_id"></a> [id](#output\_id) | The ID of the DynamoDB table |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
