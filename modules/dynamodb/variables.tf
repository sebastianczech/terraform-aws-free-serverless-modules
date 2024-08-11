variable "name" {
  description = "The name of the DynamoDB table"
  type        = string
}

variable "read_capacity" {
  description = "The read capacity of the DynamoDB table"
  type        = number
  default     = 1
}

variable "write_capacity" {
  description = "The write capacity of the DynamoDB table"
  type        = number
  default     = 1
}

variable "hash_key_name" {
  description = "The hash key name of the DynamoDB table"
  type        = string
  default     = "ID"
}

variable "hash_key_type" {
  description = "The hash key type of the DynamoDB table"
  type        = string
  default     = "S"
  validation {
    condition     = var.hash_key_type == "S" || var.hash_key_type == "N" || var.hash_key_type == "B"
    error_message = "The hash key type must be 'S', 'N', or 'B'"
  }
}
