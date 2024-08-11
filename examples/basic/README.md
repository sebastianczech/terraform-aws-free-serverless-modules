# Basic example

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | ~> 2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dynamodb"></a> [dynamodb](#module\_dynamodb) | ../../modules/dynamodb | n/a |
| <a name="module_lambda_consumer"></a> [lambda\_consumer](#module\_lambda\_consumer) | ../../modules/lambda | n/a |
| <a name="module_lambda_producer"></a> [lambda\_producer](#module\_lambda\_producer) | ../../modules/lambda | n/a |
| <a name="module_sns"></a> [sns](#module\_sns) | ../../modules/sns | n/a |
| <a name="module_sqs"></a> [sqs](#module\_sqs) | ../../modules/sqs | n/a |

## Resources

| Name | Type |
|------|------|
| [archive_file.consumer](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [archive_file.producer](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_iam_username"></a> [iam\_username](#input\_iam\_username) | The name of the IAM user | `string` | n/a | yes |
| <a name="input_mail"></a> [mail](#input\_mail) | The email address used for notifications | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix for the resources | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
