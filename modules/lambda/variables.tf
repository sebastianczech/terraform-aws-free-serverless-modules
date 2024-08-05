variable "name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "sqs" {
  description = "The SQS queue to subscribe to the SNS topic"
  type = object({
    arn = string
    url = string
  })
}

variable "iam_user_name" {
  description = "The name of the IAM user"
  type        = string
}
