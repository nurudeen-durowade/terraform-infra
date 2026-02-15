terraform {
  backend "s3" {
    bucket = "amzn-s3-tf.state"
    key    = "development/terraform_state"
    region = "us-east-1"
  }
}
