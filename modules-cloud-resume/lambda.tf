data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/lambda.py"
  output_path = "${path.module}/lambda.zip"
}

resource "aws_lambda_function" "cloud_resume_function" {
  function_name = var.function_name
  filename      = "${path.module}/lambda.zip"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda.lambda_handler"
  source_code_hash = filebase64sha256("${path.module}/lambda.zip") 
  runtime = "python3.12"
}

resource "aws_lambda_function_url" "lambda_function_url" {
  function_name      = aws_lambda_function.cloud_resume_function.function_name
  authorization_type = "NONE"

  cors {
    allow_credentials = true
    allow_origins     = ["*"]  // allow only your website url to call the lambda function
    allow_methods     = ["*"]
    allow_headers     = ["date", "keep-alive"]
    expose_headers    = ["keep-alive", "date"]
    max_age           = 86400
  }
}

resource "aws_iam_policy" "dynamodb_full_access_policy" {
  name = "DynamoDBFullAccessPolicy"
  description = "Policy for full access to DynamoDB"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*", 
      "Resource": "*" 
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach_dynamodb_policy" {
  policy_arn = aws_iam_policy.dynamodb_full_access_policy.arn
  role       = aws_iam_role.iam_for_lambda.name
}