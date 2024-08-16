# Lambda

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.61 |
| <a name="requirement_external"></a> [external](#requirement\_external) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.61 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_policy.lambda_dynamodb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.lambda_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.lambda_sns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.lambda_sqs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.lambda_dynamodb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lambda_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lambda_sns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lambda_sqs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_event_source_mapping.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_event_source_mapping) | resource |
| [aws_lambda_function.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_function_url.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function_url) | resource |
| [aws_lambda_permission.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_user.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_user) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_concurrent_executions"></a> [concurrent\_executions](#input\_concurrent\_executions) | The number of concurrent executions of the Lambda function | `number` | `1` | no |
| <a name="input_dynamodb"></a> [dynamodb](#input\_dynamodb) | The DynamoDB table to put items | <pre>object({<br>    enabled = optional(bool, false)<br>    arn     = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_filename"></a> [filename](#input\_filename) | The filename of the Lambda function | `string` | n/a | yes |
| <a name="input_handler"></a> [handler](#input\_handler) | The handler of the Lambda function | `string` | n/a | yes |
| <a name="input_iam_user_name"></a> [iam\_user\_name](#input\_iam\_user\_name) | The name of the IAM user | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Lambda function | `string` | n/a | yes |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | The runtime of the Lambda function | `string` | `"python3.12"` | no |
| <a name="input_sns"></a> [sns](#input\_sns) | The SNS topic to publish events | <pre>object({<br>    enabled = optional(bool, false)<br>    arn     = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_sqs"></a> [sqs](#input\_sqs) | The SQS queue to subscribe to the SNS topic | <pre>object({<br>    enabled        = optional(bool, false)<br>    trigger_lambda = optional(bool, false)<br>    arn            = optional(string)<br>    url            = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | The timeout of the Lambda function | `number` | `10` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_url"></a> [url](#output\_url) | The URL of the Lambda function |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
