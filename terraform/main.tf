resource "aws_s3_bucket" "terraform_state" {
  count  = var.create_s3_bucket ? 1 : 0
  bucket = var.bucket_name

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_encryption" {
  count  = var.create_s3_bucket ? 1 : 0
  bucket = aws_s3_bucket.terraform_state[count.index].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  count  = var.create_s3_bucket ? 1 : 0
  bucket = aws_s3_bucket.terraform_state[count.index].id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "dynamodb_terraform_lock" {
  for_each = toset(var.projects)

  name         = "lock-${each.value}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
