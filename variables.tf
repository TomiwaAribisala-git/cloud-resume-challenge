variable bucket_name {
    description = "The name of the s3 bucket"
    type = string
}

variable content_version {
    description = "The version value of the s3 objects"
    type = number
}

variable table_name {
    description = "The name of the DynamoDB Table"
    type = string
}

variable hash_key {
    description = "The partition key of the DynamoDB Table"
    type = string
}

variable function_name {
    description = "The name of the Lambda function"
    type = string
}