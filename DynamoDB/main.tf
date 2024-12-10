provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_dynamodb_table" "table-for-state-locking" {
  name           = "table-for-state-locking"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}