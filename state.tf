# Terraform backend config
terraform {
  backend "s3" {
    bucket     = "campus-bucket-jh-testing"
    key        = "state/terraform.tfstate"
    region     = "sa-east-1"
    encrypt    = true
    kms_key_id = "alias/campus-key-bucket-testing"
  }

}

# Bucket Key
resource "aws_kms_key" "bucket-key" {
  name = "Campus-Keys"
  enable_key_rotation = true
  description = "This key is used to encrypt bucket objects"
}

resource "aws_kms_alias" "key-alias" {
  name          = "alias/campus-key-testing"
  target_key_id = aws_kms_key.bucket-key.key_id
}