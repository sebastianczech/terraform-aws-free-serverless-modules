variable "name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "filename" {
  description = "The filename of the Lambda function"
  type        = string
}

variable "runtime" {
  description = "The runtime of the Lambda function"
  default     = "python3.12"
  type        = string
}

variable "handler" {
  description = "The handler of the Lambda function"
  type        = string
}

variable "timeout" {
  description = "The timeout of the Lambda function"
  default     = 10
  type        = number
}

variable "concurrent_executions" {
  description = "The number of concurrent executions of the Lambda function"
  default     = 1
  type        = number
}

variable "sqs" {
  description = "The SQS queue to subscribe to the SNS topic"
  type = object({
    enabled        = optional(bool, false)
    trigger_lambda = optional(bool, false)
    arn            = optional(string)
    url            = optional(string)
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
