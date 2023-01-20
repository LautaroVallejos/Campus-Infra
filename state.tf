# Terraform backend config
terraform {
  backend "s3" {
    bucket         = "campus-bucket-jh"
    key            = "state/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    kms_key_id     = "alias/bucket-key"
  }

}

# Bucket Key
resource "aws_kms_key" "bucket-key" {
  description             = "This key is used to encrypt bucket objects"
}

resource "aws_kms_alias" "key-alias" {
 name          = "alias/campus-key-bucket"
 target_key_id = aws_kms_key.bucket-key.key_id
}