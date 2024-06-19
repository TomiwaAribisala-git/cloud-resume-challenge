output "cdn_domain_name" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}

output "lambda_function_url" {
  value = aws_lambda_function_url.lambda_function_url.function_url
}