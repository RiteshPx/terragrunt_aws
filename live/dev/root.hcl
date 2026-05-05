remote_state {
  backend = "s3"

  config = {
    bucket         = "my-terraform-state-bucket-25-1"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}