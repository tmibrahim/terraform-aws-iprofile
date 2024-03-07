resource "aws_db_subnet_group" "vprofile-rds-subgrp" {
  name = main
  description = "VPC RDS Subnet Group"
  subnet_ids = [ module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]
  tags = {
    Name = "Subnet Group for RDS"
  }
}

resource "aws_elasticache_subnet_group" "vprofile-ecache-subgrp" {
  name = "vprofile-ecache-subgrp"
  description = "VPC ElastiCache Subnet Group"
  subnet_ids = [module.vps.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]
  tags = {
    Name = "Subnet Group for ElastiCache"
  }
}

resource "aws_db_instance" "vprofile-rds" {
  allocated_storage = 20
  storage_type = "gp2"
  engine = "mysql"
  engine_version = "5.6.34"
  instance_class = "db.t2.micro"
  db_name = var.db_name
  username = var.db_username
  password = var.db_password
  parameter_group_name = "default.mysql5.6"
  skip_final_snapshot =true
  vpc_security_group_ids = [aws_security_group.vprofile-backend-sg.id]
  db_subnet_group_name = aws_db_subnet_group.vprofile-rds-subgrp.name
}

resource "aws_elasticache_cluster" "vrpofile_cache" {
  cluster_id = "vprofile-cache"
  engine = "memcached"
  node_type = "cache.t2.micro"
  num_cache_nodes = 1
  parameter_group_name = "default.memcached1.5"
  port = 11211
  subnet_group_name = aws_elasticache_subnet_group.vprofile-ecache-subgrp.name
  security_group_ids = [aws_security_group.vprofile-backend-sg.id]
}

resource "aws_mq_broker" "vprofile-rmq" {
  broker_name = "vprofile-rmq"
  engine_type = "ActiveMQ"
  engine_version = "5.15.0"
  host_instance_type = "mq.t2.micro"
  publicly_accessible = false
  subnet_ids = [module.vpc.private_subnets[0]]
  security_groups = [aws_security_group.vprofile-backend-sg.id]

  user {
    username = var.rmq_username
    password = var.rmq_password
  }
}

