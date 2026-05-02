output "s3_bucket_name" {
  description = "Name of the S3 bucket created"
  value       = aws_s3_bucket.talium_assets.bucket
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.talium_assets.arn
}

output "aws_region" {
  description = "AWS region resources were deployed to"
  value       = var.aws_region
}
