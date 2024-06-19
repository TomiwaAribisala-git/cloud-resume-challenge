resource "aws_dynamodb_table" "resume_table" {
  name           = var.table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = 10
  write_capacity = 10
  hash_key       = var.hash_key

  attribute {
    name = "resume_views"
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "views" {
  table_name = aws_dynamodb_table.resume_table.name
  hash_key   = aws_dynamodb_table.resume_table.hash_key

  item = <<ITEM
{
"resume_views": {"S": "0"},
"views": {"N": "0"}
}
ITEM
}
