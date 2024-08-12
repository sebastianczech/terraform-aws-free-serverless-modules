variable "name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "filename" {
  description = "The filename of the Lambda function"
  type        = string
}

variable "handler" {
  description = "The handler of the Lambda function"
  type        = string
}

variable "sqs" {
  description = "The SQS queue to subscribe to the SNS topic"
  type = object({
    enabled = optional(bool, false)
    arn     = optional(string)
    url     = optional(string)
  })
}

variable "sns" {
  description = "The SNS topic to publish events"
  type = object({
    enabled = optional(bool, false)
    arn     = optional(string)
  })
}

variable "dynamodb" {
  description = "The DynamoDB table to put items"
  type = object({
    enabled = optional(bool, false)
    arn     = optional(string)
  })
}

variable "iam_user_name" {
  description = "The name of the IAM user"
  type        = string
}
