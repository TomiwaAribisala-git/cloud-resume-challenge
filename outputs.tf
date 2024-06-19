output "cdn_domain_name" {
  description = "cloudfront distribution domain name serving s3 bucket"
  value = module.cloud-resume.cdn_domain_name
}

output "lambda_function_url" {
  description = "cloudfront distribution domain name serving s3 bucket"
  value = module.cloud-resume.lambda_function_url
}