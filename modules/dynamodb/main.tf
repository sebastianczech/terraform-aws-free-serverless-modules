# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table
resource "aws_dynamodb_table" "this" {
  name           = var.name
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = var.hash_key_name

  attribute {
    name = var.hash_key_name
    type = var.hash_key_type
  }
}
