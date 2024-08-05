output "id" {
  description = "The ID of the SQS queue"
  value       = aws_sqs_queue.this.id
}

output "arn" {
  description = "The ARN of the SQS queue"
  value       = aws_sqs_queue.this.arn
}

output "url" {
  description = "The URL of the SQS queue"
  value       = aws_sqs_queue.this.url
}
