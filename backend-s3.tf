terraform {
  backend "s3" {
    bucket = "terra-state-iprofile"
    key = "terraform/backend"
    region = var.AWS_REGION
  }
}