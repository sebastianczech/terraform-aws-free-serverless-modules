module "lambda" {
  source  = "sebastianczech/free-serverless-modules/aws//modules/lambda"
  version = "1.1.2-rc.1"

  name          = "my-lambda"
  iam_user_name = "my-iam-user"
  sqs = {
    arn = "arn:aws:sqs:us-east-1:123456789012:my-sqs"
    url = "https://sqs.us-east-1.amazonaws.com/123456789012/my-sqs"
  }
}

module "dynamodb" {
  source  = "sebastianczech/free-serverless-modules/aws//modules/dynamodb"
  version = "1.1.2-rc.1"

  name           = "my-dynamodb"
  read_capacity  = 5
  write_capacity = 5
}

module "sns" {
  source  = "sebastianczech/free-serverless-modules/aws//modules/sns"
  version = "1.1.2-rc.1"

  name  = "my-sns"
  email = "example@example.com"
}

module "sqs" {
  source  = "sebastianczech/free-serverless-modules/aws//modules/sqs"
  version = "1.1.2-rc.1"

  name = "my-sqs"
}
