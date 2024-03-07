variable AWS_REGION {
  default = "eu-west-1"
}

variable AMIS {
  type = map
  default = {
    eu-west-1 = "ami-0d940f23d527c3ab1"
    eu-west-1 = "ami-01505b5fb77668db8"
  } 
}

variable PRIV_KEY {
  default = "vprofilekey"
}

variable PUB_KEY {
  default = "vprofilekey.pub"
}

variable USERNAME {
  default = "ubuntu"
}

variable MY_IP {
  default = "5.27.8.52/32"
}

variable rmq_username {
  default = "rabbit"
}

variable rmq_password {
  default = "Superp0werr@bbitpassw0rd"
}

variable db_username {
  default = "admin"
}

variable db_password {
  default = "Superp0werr@dbpassw0rd"
}

variable db_name {
  default = "accounts"
}

variable instance_count {
  default = 1
}

variable VPC_NAME {
  default = "vprofile-VPC"
}

variable ZoneA {
  default = "eu-west-1a"
}

variable ZoneB {
  default = "eu-west-1b"
}

variable ZoneC {
  default = "eu-west-1c"
}

variable VPC_CIDR {
  default = "172.31.0.0/16"
}

variable PUBLIC_SUBNET_CIDR1 {
  default = "172.31.1.0/24"
}

variable PUBLIC_SUBNET_CIDR2 {
  default = "172.31.2.0/24"
}

variable PUBLIC_SUBNET_CIDR3 {
  default = "172.31.3.0/24"
}

variable PRIV_SUBNET_CIDR1 {
  default = "172.31.4.0/24"
}

variable PRIV_SUBNET_CIDR2 {
  default = "172.31.5.0/24"
}

variable PRIV_SUBNET_CIDR3 {
  default = "172.31.6.0/24"
}