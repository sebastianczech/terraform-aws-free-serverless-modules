module "lambda" {
  source  = "sebastianczech/free-serverless-modules/aws//modules/lambda"
  version = "1.1.2"

  name          = "my-lambda"
  iam_user_name = "my-iam-user"
  sqs = {
    arn = "arn:aws:sqs:us-east-1:123456789012:my-sqs"
    url = "https://sqs.us-east-1.amazonaws.com/123456789012/my-sqs"
  }
}
