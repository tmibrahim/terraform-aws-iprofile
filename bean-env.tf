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
    name = "Avsailability Zones"
    value = "Any 3"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name = "MinSize"
    value = "1"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name = "MaxSize"
    value = "4"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name = "environment"
    value = "prod"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name = "LOGGING_APPENDER"
    value = "GRAYLOG"
  }
  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name = "SystemType"
    value = "basic"
  }
  setting {
    namespace = "aws:autoscaling:updadepoliciy:rollingupdate"
    name = "RollingUpdateEnabled"
    value = "true"
  }
  setting {
    namespace = "aws:autoscaling:updadepoliciy:rollingupdate"
    name = "RollingUpdateType"
    value = "Health"
  }
  setting {
    namespace = "aws:autoscaling:updadepoliciy:rollingupdate"
    name = "MaxBatchSize"
    value = "1"
  }
  setting {
    namespace = "aws:elb:loadbalancer"
    name = "CrossZone"
    value = "true"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name = "StickinessEnabled"
    value = true
  }
  setting {
    namespace = "aws:elasticbeanstalk:command"
    name = "BatchSizeType"
    value = "Fixed"
  }
  setting {
    namespace = "aws:elasticbeanstalk:command"
    name = "BatchSize"
    value = "1"
  }
  setting {
    namespace = "aws:elasticbeanstalk:command"
    name = "DeploymentPolicy"
    value = "Rolling"
  }
  setting {
    namespace = "aws:autoScaling:launchconfiguration"
    name = "SecurityGroups"
    value = aws_security_group.vprofile-prod-sg.id
  }
  setting {
    namespace = "aws:elbv2:loadbalancer"
    name = "SecurityGroups"
    value = aws_security_group.vprofile-bean-elb-sg.id
  }
  depends_on = [ aws_security_group.vprofile-bean-elb-sg,aws_security_group.vprofile-prod-sg ]
}