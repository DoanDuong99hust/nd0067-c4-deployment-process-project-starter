resource "aws_elastic_beanstalk_application" "udagramapp" {
  name        = "Udagram App"
  description = "Udagram App"
}

resource "aws_elastic_beanstalk_environment" "udagramenv" {
  name                = "udagram-env"
  application         = aws_elastic_beanstalk_application.udagramapp.name
  solution_stack_name = "64bit Amazon Linux 2015.03 v2.0.3 running Go 1.4"

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = "vpc-xxxxxxxx"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"   
    value     = "subnet-xxxxxxxx"
  }
}