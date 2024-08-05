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

resource "aws_iam_role" "this" {
  name               = "${var.name}_lambda_role"
  assume_role_policy = data.aws_iam_policy_document.this.json
}

data "archive_file" "this" {
  type = "zip"
  source {
    content = templatefile("files/code.py", {
      queue_url = var.sqs.url
    })
    filename = "coder.py"
  }
  output_path = "files/code.zip"
}

# https://awspolicygen.s3.amazonaws.com/policygen.html
resource "aws_iam_policy" "lambda_sqs" {
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
        "sqs:SendMessage"
      ],
      "Effect": "Allow",
      "Resource": "${var.sqs.arn}"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_sqs" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.lambda_sqs.arn
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function
resource "aws_lambda_function" "this" {
  filename         = data.archive_file.this.output_path
  function_name    = var.name
  role             = aws_iam_role.this.arn
  source_code_hash = filebase64sha256(data.archive_file.this.output_path)

  runtime = "python3.12"
  handler = "code.lambda_handler"
  timeout = 10

  environment {
    variables = {
      foo = "bar"
    }
  }
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${var.name}"
  retention_in_days = 1
}

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

resource "aws_iam_role_policy_attachment" "lambda_logging" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

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

data "aws_iam_user" "this" {
  user_name = var.iam_user_name
}

resource "aws_lambda_permission" "this" {
  statement_id           = "AllowExecutionForIamUser"
  action                 = "lambda:InvokeFunctionUrl"
  function_name          = aws_lambda_function.this.function_name
  function_url_auth_type = "AWS_IAM"
  principal              = data.aws_iam_user.this.arn
}

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
