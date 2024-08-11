module "lambda" {
  source = "sebastianczech/free-serverless-modules/aws//modules/lambda"

  name          = "my-lambda"
  iam_user_name = "my-iam-user"
  sqs = {
    arn = "arn:aws:sqs:us-east-1:123456789012:my-sqs"
    url = "https://sqs.us-east-1.amazonaws.com/123456789012/my-sqs"
  }
}

module "dynamodb" {
  source = "sebastianczech/free-serverless-modules/aws//modules/dynamodb"

  name           = "my-dynamodb"
  read_capacity  = 5
  write_capacity = 5
}

module "sns" {
  source = "sebastianczech/free-serverless-modules/aws//modules/sns"

  name     = "my-sns"
  protocol = "email"
  endpoint = "example@example.com"
}

module "sqs" {
  source = "sebastianczech/free-serverless-modules/aws//modules/sqs"

  name = "my-sqs"
}
