# S3 bucket for Talium-Tech assets
resource "aws_s3_bucket" "talium_assets" {
  bucket = "${var.project_name}-assets-${var.environment}-${random_id.suffix.hex}"

  tags = {
  Name    = "${var.project_name}-assets-${var.environment}"
  Purpose = "static-assets"
}

}

# Random suffix to ensure bucket name is unique globally
resource "random_id" "suffix" {
  byte_length = 4
}

# Block all public access — security best practice
resource "aws_s3_bucket_public_access_block" "talium_assets" {
  bucket = aws_s3_bucket.talium_assets.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable versioning
resource "aws_s3_bucket_versioning" "talium_assets" {
  bucket = aws_s3_bucket.talium_assets.id

  versioning_configuration {
    status = "Enabled"
  }
}
