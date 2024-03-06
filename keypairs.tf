resource "aws_key_pair" "vprofilekey" {
  key_name = var.PRIV_KEY
  public_key = file(var.PUB_KEY)
}

