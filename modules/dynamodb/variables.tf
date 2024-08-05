variable "name" {
  description = "The name of the DynamoDB table"
  type        = string
}

variable "read_capacity" {
  description = "The read capacity of the DynamoDB table"
  type        = string
  default     = "1"
}

variable "write_capacity" {
  description = "The write capacity of the DynamoDB table"
  type        = string
  default     = "1"
}
