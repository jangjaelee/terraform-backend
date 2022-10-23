resource "aws_s3_bucket" "terraform_state_backend" {
  bucket = var.bucket

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name = var.bucket
  }
}

resource "aws_s3_bucket_acl" "terraform_state_backend_acl" {
  bucket = aws_s3_bucket.terraform_state_backend.id
  acl = var.s3_acl
}

resource "aws_s3_bucket_versioning" "terraform_state_backend_versioning" {
  bucket = aws_s3_bucket.terraform_state_backend.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_backend_encryption" {
  bucket = aws_s3_bucket.terraform_state_backend.id

  rule {
    apply_server_side_encryption_by_default {
      #kms_master_key_id = aws_kms_key.mykey.arn
      #sse_algorithm     = "aws:kms"
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "terraform_state_locks" {
  name = var.dynamodb_table
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name = var.dynamodb_table
  }
}

