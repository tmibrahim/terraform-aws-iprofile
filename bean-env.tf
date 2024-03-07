resource "aws_elastic_beanstalk_environment" "vprofile-bean-env" {
  name                = "vprofile-bean-env"
  application         = aws_elastic_beanstalk_application.vprofile-bean-app.name
  solution_stack_name = "64bit Amazon Linux 2023 v5.1.4 running Tomcat 9 Corretto 11"
  cname_prefix       = "vprofile-bean-env-domain"
  setting {
    namespace = "aws:ec2:vpc"
    name = "VPCId"
    value = module.vpc.vpc_id
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "IamInstanceProfile"
    value = "aws-elasticbeanstalk-ec2-role"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "AssociatePublicIpAdress"
    value = "false"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "Subnets"
    value = join(", " ,[module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]])
  }
  setting {
    namespace = "awc:ec2:vpc"
    name = "ELBSubnets"
    value = join(", " ,[module.vpc.public_subnets[0], module.vpc.public_subnets[1], module.vpc.public_subnets[2]])
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "InstanceType"
    value = "t2.micro"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "EC2KeyName"
    value = aws_key_pair.vprofilekey.key_name
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name = "MinSize"
    value = "1"
  }
}