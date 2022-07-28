# SETUP TERRAFORM STATE

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-s3backend"
  # Enable versioning so we can see the full revision history of our
  # state files
  versioning {
    enabled = true
  }
  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket                  = "terraform-state-s3backend"
    key                     = ".../terraform.tfstate"
    region                  = "us-east-1"
    encrypt                 = true
    profile                 = "default"
    dynamodb_table          = "terraform-lock-table"
    shared_credentials_file = "$HOME/.aws/credentials"
  }
}