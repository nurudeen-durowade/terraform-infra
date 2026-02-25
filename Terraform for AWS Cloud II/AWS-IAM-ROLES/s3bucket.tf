#Create AWS s3 bucket

resource "aws_s3_bucket" "apibox_s3bucket" {
  bucket = "apibox_bucket-555"

  tags = {
    Name = "apibox_bucket-555"
  }
}

resource "aws_s3_bucket_ownership_controls" "apibox_s3bucket" {
  bucket = aws_s3_bucket.apibox_s3bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}
