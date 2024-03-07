module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.VPC_NAME
  cidr = var.VPC_CIDR
  azs = [var.ZoneA, var.ZoneB, var.ZoneC]
  private_subnets = [var.PRIV_SUBNET_CIDR1, var.PRIV_SUBNET_CIDR2, var.PRIV_SUBNET_CIDR3]
  public_subnets = [var.PUBLIC_SUBNET_CIDR1, var.PUBLIC_SUBNET_CIDR2, var.PUBLIC_SUBNET_CIDR3]
  
  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Terraform = "true"
    Environment = "Prod"
  }
  vpc_tags = {
    Name = var.VPC_NAME
}
}