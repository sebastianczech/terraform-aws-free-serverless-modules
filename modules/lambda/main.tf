# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
data "aws_iam_policy_document" "this" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
resource "aws_iam_role" "this" {
  name               = "${var.name}_lambda_role"
  assume_role_policy = data.aws_iam_policy_document.this.json
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function
resource "aws_lambda_function" "this" {
  filename         = var.filename
  function_name    = var.name
  role             = aws_iam_role.this.arn
  source_code_hash = filebase64sha256(var.filename)

  runtime                        = var.runtime
  handler                        = var.handler
  timeout                        = var.timeout
  reserved_concurrent_executions = var.concurrent_executions

  environment {
    variables = {
      foo = "bar"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function_url
resource "aws_lambda_function_url" "this" {
  function_name      = aws_lambda_function.this.function_name
  authorization_type = "AWS_IAM" # "NONE"

  cors {
    allow_credentials = true
    allow_origins     = ["*"]
    allow_methods     = ["*"]
    allow_headers     = ["date", "keep-alive"]
    expose_headers    = ["keep-alive", "date"]
    max_age           = 86400
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_user
data "aws_iam_user" "this" {
  user_name = var.iam_user_name
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission
resource "aws_lambda_permission" "this" {
  statement_id           = "AllowExecutionForIamUser"
  action                 = "lambda:InvokeFunctionUrl"
  function_name          = aws_lambda_function.this.function_name
  function_url_auth_type = "AWS_IAM"
  principal              = data.aws_iam_user.this.arn
}

# https://developer.hashicorp.com/terraform/language/checks
check "lambda_deployed" {
  data "external" "this" {
    program = ["curl", aws_lambda_function_url.this.function_url]
  }

  assert {
    condition = data.external.this.result.Message == "Forbidden"
    error_message = format("The Lambda %s is not deployed.",
      aws_lambda_function.this.function_name
    )
  }
}

# https://awspolicygen.s3.amazonaws.com/policygen.html
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy
resource "aws_iam_policy" "lambda_sqs" {
  count = var.sqs.enabled ? 1 : 0

  name        = "${var.name}_lambda_sqs"
  path        = "/"
  description = "IAM policy for sending messages to SQS from a Lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "LambdaStatement",
      "Action": [
        "sqs:SendMessage",
        "sqs:ReceiveMessage",
        "sqs:DeleteMessage",
        "sqs:GetQueueAttributes"
      ],
      "Effect": "Allow",
      "Resource": "${var.sqs.arn}"
    }
  ]
}
EOF
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment
resource "aws_iam_role_policy_attachment" "lambda_sqs" {
  count = var.sqs.enabled ? 1 : 0

  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.lambda_sqs[0].arn
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy
resource "aws_iam_policy" "lambda_sns" {
  count = var.sns.enabled ? 1 : 0

  name        = "${var.name}_lambda_sns"
  path        = "/"
  description = "IAM policy for publish events from Lambda to SNS"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "LambdaStatement",
      "Action": [
        "sns:Publish"
      ],
      "Effect": "Allow",
      "Resource": "${var.sns.arn}"
    }
  ]
}
EOF
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment
resource "aws_iam_role_policy_attachment" "lambda_sns" {
  count = var.sns.enabled ? 1 : 0

  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.lambda_sns[0].arn
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_event_source_mapping
resource "aws_lambda_event_source_mapping" "this" {
  count            = var.sqs.trigger_lambda ? 1 : 0
  event_source_arn = var.sqs.arn
  function_name    = aws_lambda_function.this.arn
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy
resource "aws_iam_policy" "lambda_dynamodb" {
  count = var.dynamodb.enabled ? 1 : 0

  name        = "${var.name}_lambda_dynamodb"
  path        = "/"
  description = "IAM policy for put items from Lambda to DynamoDB"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "LambdaStatement",
      "Action": [
        "dynamodb:PutItem"
      ],
      "Effect": "Allow",
      "Resource": "${var.dynamodb.arn}"
    }
  ]
}
EOF
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment
resource "aws_iam_role_policy_attachment" "lambda_dynamodb" {
  count = var.dynamodb.enabled ? 1 : 0

  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.lambda_dynamodb[0].arn
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group
resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${var.name}"
  retention_in_days = 1
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy
resource "aws_iam_policy" "lambda_logging" {
  name        = "${var.name}_lambda_logging"
  path        = "/"
  description = "IAM policy for logging from Lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment
resource "aws_iam_role_policy_attachment" "lambda_logging" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}
