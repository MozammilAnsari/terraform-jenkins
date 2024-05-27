provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "site7488" {
  bucket = "site7488"
}

resource "aws_s3_bucket_public_access_block" "site7488" {
  bucket                  = aws_s3_bucket.site7488.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "site7488" {
  bucket = aws_s3_bucket.site7488.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_ownership_controls" "site7488" {
  bucket = aws_s3_bucket.site7488.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "site7488" {
  bucket = aws_s3_bucket.site7488.id
  acl    = "public-read"
  depends_on = [
    aws_s3_bucket_ownership_controls.site7488,
    aws_s3_bucket_public_access_block.site7488
  ]
}

resource "aws_s3_bucket_policy" "site7488" {
  bucket = aws_s3_bucket.site7488.id

  policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.site7488.arn}/*"
      }
    ]
  })

  depends_on = [
    aws_s3_bucket_public_access_block.site7488
  ]
}

resource "aws_s3_object" "revhire" {
  for_each = fileset("C:/Users/Mozammil/Desktop/revhire-trng-1903/dist/revhire/", "**/*")
  bucket   = aws_s3_bucket.site7488.bucket
  key      = "revhire/${each.key}"
  source   = "C:/Users/Mozammil/Desktop/revhire-trng-1903/dist/revhire/${each.key}"
  acl      = "public-read"
  content_type = lookup({
    "html" = "text/html"
    "css"  = "text/css"
    "js"   = "application/javascript"
    "json" = "application/json"
    "png"  = "image/png"
    "jpg"  = "image/jpeg"
    "jpeg" = "image/jpeg"
    "gif"  = "image/gif"
    "ico"  = "image/x-icon"
    "svg"  = "image/svg+xml"
    "woff" = "font/woff"
    "woff2"= "font/woff2"
    "ttf"  = "font/ttf"
    "otf"  = "font/otf"
  }, regex("[^.]*$", each.key), "application/octet-stream")

}

resource "aws_s3_object" "assets" {
  for_each = fileset("C:/Users/Mozammil/Desktop/revhire-trng-1903/dist/revhire/assets/", "**/*")
  bucket   = aws_s3_bucket.site7488.bucket
  key      = "revhire/assets/${each.key}"
  source   = "C:/Users/Mozammil/Desktop/revhire-trng-1903/dist/revhire/assets/${each.key}"
  acl      = "public-read"
  content_type = lookup({
    "html" = "text/html"
    "css"  = "text/css"
    "js"   = "application/javascript"
    "json" = "application/json"
    "png"  = "image/png"
    "jpg"  = "image/jpeg"
    "jpeg" = "image/jpeg"
    "gif"  = "image/gif"
    "ico"  = "image/x-icon"
    "svg"  = "image/svg+xml"
    "woff" = "font/woff"
    "woff2"= "font/woff2"
    "ttf"  = "font/ttf"
    "otf"  = "font/otf"
  }, regex("[^.]*$", each.key), "application/octet-stream")

}

resource "aws_s3_object" "tenor_sans" {
  for_each = fileset("C:/Users/Mozammil/Desktop/revhire-trng-1903/dist/revhire/assets/tenor_sans/", "**/*")
  bucket   = aws_s3_bucket.site7488.bucket
  key      = "revhire/assets/tenor_sans/${each.key}"
  source   = "C:/Users/Mozammil/Desktop/revhire-trng-1903/dist/revhire/assets/tenor_sans/${each.key}"
  acl      = "public-read"
  content_type = lookup({
    "html" = "text/html"
    "css"  = "text/css"
    "js"   = "application/javascript"
    "json" = "application/json"
    "png"  = "image/png"
    "jpg"  = "image/jpeg"
    "jpeg" = "image/jpeg"
    "gif"  = "image/gif"
    "ico"  = "image/x-icon"
    "svg"  = "image/svg+xml"
    "woff" = "font/woff"
    "woff2"= "font/woff2"
    "ttf"  = "font/ttf"
    "otf"  = "font/otf"
  }, regex("[^.]*$", each.key), "application/octet-stream")

}
