# https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file
data "archive_file" "producer" {
  type = "zip"
  source {
    content = templatefile("files/producer.py", {
      queue_url = module.sqs.id
    })
    filename = "producer.py"
  }
  output_path = "files/producer.zip"
}

# https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file
data "archive_file" "consumer" {
  type = "zip"
  source {
    content = templatefile("files/consumer.py", {
      topic_url = module.sns.id,
      table_url = module.dynamodb.id
    })
    filename = "consumer.py"
  }
  output_path = "files/consumer.zip"
}

module "lambda_producer" {
  source = "../../modules/lambda"

  name          = "${var.prefix}-lambda-producer"
  iam_user_name = var.iam_username

  filename = data.archive_file.producer.output_path
  handler  = "producer.lambda_handler"

  sqs = {
    enabled = true
    arn     = module.sqs.arn
  }

  sns = {
    enabled = false
  }

  dynamodb = {
    enabled = false
  }
}

module "lambda_consumer" {
  source = "../../modules/lambda"

  name          = "${var.prefix}-lambda-consumer"
  iam_user_name = var.iam_username

  filename = data.archive_file.consumer.output_path
  handler  = "consumer.lambda_handler"

  sqs = {
    enabled        = true
    trigger_lambda = true
    arn            = module.sqs.arn
  }

  sns = {
    enabled = true
    arn     = module.sns.arn
  }

  dynamodb = {
    enabled = true
    arn     = module.dynamodb.arn
  }
}

module "dynamodb" {
  source = "../../modules/dynamodb"

  name = "${var.prefix}-dynamodb"
}

module "sns" {
  source = "../../modules/sns"

  name     = "${var.prefix}-sns"
  protocol = "email"
  endpoint = var.mail
}

module "sqs" {
  source = "../../modules/sqs"

  name = "${var.prefix}-sqs"
}
