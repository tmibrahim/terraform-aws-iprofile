terraform {
  backend "s3" {
    bucket = "terra-state-iprofile"
    key = "terraform/backend"
    region = "eu-west-1"
  }
}