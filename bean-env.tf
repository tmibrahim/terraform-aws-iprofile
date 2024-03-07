resource "aws_elastic_beanstalk_environment" "vprofile-bean-env" {
  name                = "vprofile-bean-env"
  application         = aws_elastic_beanstalk_application.vprofile-bean-app.name
  solution_stack_name = "64bit Amazon Linux 2023 v5.1.4 running Tomcat 9 Corretto 11"
  
}