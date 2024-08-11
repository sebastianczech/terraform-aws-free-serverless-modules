variable "name" {
  description = "The name of the SNS topic"
  type        = string
}

variable "protocol" {
  description = "The protocol type for the SNS subscription"
  type        = string
  validation {
    condition     = var.protocol == "email" || var.protocol == "sms" || var.protocol == "lambda" || var.protocol == "sqs" || var.protocol == "application"
    error_message = "The protocol type must be 'email', 'sms', 'lambda', 'sqs', or 'application'"
  }
}

variable "endpoint" {
  description = "The email address to subscribe to the SNS topic"
  type        = string
}
