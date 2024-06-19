resource "aws_s3_bucket" "resume-bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_object" "upload_icons" {
  for_each = fileset("${path.root}/public/icons","*.{jpg,png,gif}")
  bucket = aws_s3_bucket.resume-bucket.id
  key    = "icons/${each.key}"
  source = "${path.root}/public/icons/${each.key}"
  etag = filemd5("${path.root}/public/icons/${each.key}")
  lifecycle {
    replace_triggered_by = [terraform_data.content_version.output]
    ignore_changes = [etag]
  }
}

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.resume-bucket.id
  key    = "index.html"
  source = "${path.root}/public/index.html"
  content_type = "text/html"
  etag = filemd5("${path.root}/public/index.html")
  lifecycle {
    replace_triggered_by = [terraform_data.content_version.output]
    ignore_changes = [etag]
  }
}

resource "aws_s3_object" "index_css" {
  bucket = aws_s3_bucket.resume-bucket.id
  key    = "index.css"
  source = "${path.root}/public/index.css"
  content_type = "text/css"
  etag = filemd5("${path.root}/public/index.css")
  lifecycle {
    replace_triggered_by = [terraform_data.content_version.output]
    ignore_changes = [etag]
  }
}

resource "aws_s3_object" "index_js" {
  bucket = aws_s3_bucket.resume-bucket.id
  key    = "index.js"
  source = "${path.root}/public/index.js"
  content_type = "text/javascript"
  etag = filemd5("${path.root}/public/index.js")
  lifecycle {
    replace_triggered_by = [terraform_data.content_version.output]
    ignore_changes = [etag]
  }
}

data "aws_iam_policy_document" "allow_access_from_cloudfront" {
  statement {
    principals {
      type = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.resume-bucket.arn,
      "${aws_s3_bucket.resume-bucket.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_policy" "website-bucket-policy" {
  bucket = aws_s3_bucket.resume-bucket.id
  policy = data.aws_iam_policy_document.allow_access_from_cloudfront.json
}

resource "terraform_data" "content_version" {
  input = var.content_version
}