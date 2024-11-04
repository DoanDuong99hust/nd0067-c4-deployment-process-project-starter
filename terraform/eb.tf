# # eb.tf

# # Create elastic beanstalk application

# resource "aws_elastic_beanstalk_application" "elasticapp" {
#   name = "${local.base_name}-app"
# }

# resource "aws_security_group" "instances" {
#   name = "${local.base_name}-sg"
# }

# resource "aws_security_group_rule" "allow_http_inbound" {
#   type              = "ingress"
#   security_group_id = aws_security_group.instances.id

#   from_port   = 80
#   to_port     = 80
#   protocol    = "tcp"
#   source_security_group_id = aws_security_group.alb.id
# }
# resource "aws_security_group_rule" "allow_https_inbound" {
#   type              = "ingress"
#   security_group_id = aws_security_group.instances.id
#   from_port   = 443
#   to_port     = 443
#   protocol    = "tcp"
#   cidr_blocks = ["0.0.0.0/0"]
# }


# resource "aws_security_group" "alb" {
#   name = "${local.base_name}-alb-sg"
# }

# resource "aws_security_group_rule" "allow_alb_http_inbound" {
#   type              = "ingress"
#   security_group_id = aws_security_group.alb.id

#   from_port   = 80
#   to_port     = 80
#   protocol    = "tcp"
#   cidr_blocks = ["0.0.0.0/0"]

# }
# resource "aws_security_group_rule" "allow_alb_https_inbound" {
#   type              = "ingress"
#   security_group_id = aws_security_group.alb.id

#   from_port   = 443
#   to_port     = 443
#   protocol    = "tcp"
#   cidr_blocks = ["0.0.0.0/0"]

# }

# resource "aws_security_group_rule" "allow_alb_all_outbound" {
#   type              = "egress"
#   security_group_id = aws_security_group.alb.id

#   from_port   = 0
#   to_port     = 0
#   protocol    = "-1"
#   cidr_blocks = ["0.0.0.0/0"]

# }

# # Create elastic beanstalk Environment

# resource "aws_elastic_beanstalk_environment" "beanstalkappenv" {
#   name                = "${local.base_name}-env"
#   application         = aws_elastic_beanstalk_application.elasticapp.name
#   solution_stack_name = var.solution_stack_name
#   tier                = var.tier

#   setting {
#     namespace = "aws:ec2:vpc"
#     name      = "VPCId"
#     value     = data.aws_vpc.default_vpc.id
#   }

#   setting {
#     namespace = "aws:autoscaling:launchconfiguration"
#     name      = "IamInstanceProfile"
#     value     =  "aws-elasticbeanstalk-ec2-role"
#   }

#   setting {
#     namespace = "aws:autoscaling:launchconfiguration"
#     name      = "SecurityGroups"
#     value     = aws_security_group.instances.id
#   }
#   setting {
#     namespace = "aws:ec2:vpc"
#     name      = "AssociatePublicIpAddress"
#     value     =  "True"
#   }

#   setting {
#     namespace = "aws:ec2:vpc"
#     name      = "Subnets"
#     value     = join(",", data.aws_subnet_ids.default_subnet.ids)
#   }
#   setting {
#     namespace = "aws:elasticbeanstalk:environment:process:default"
#     name      = "MatcherHTTPCode"
#     value     = "200"
#   }
#   setting {
#     namespace = "aws:elasticbeanstalk:environment"
#     name      = "LoadBalancerType"
#     value     = "application"
#   }
#   setting {
#     namespace = "aws:autoscaling:launchconfiguration"
#     name      = "InstanceType"
#     value     = var.instance_type
#   }
#   setting {
#     namespace = "aws:ec2:vpc"
#     name      = "ELBScheme"
#     value     = "internet facing"
#   }

#   setting {
#     namespace = "aws:elasticbeanstalk:healthreporting:system"
#     name      = "SystemType"
#     value     = "enhanced"
#   }

#   setting {
#     namespace = "aws:elbv2:listener:443"
#     name      = "Protocol"
#     value     = "HTTPS"
#   }
#     setting {
#     namespace = "aws:elbv2:listener:443"
#     name      = "SSLCertificateArns"
#     value     = var.certificate_arn
#   }

#    setting {
#     namespace = "aws:elbv2:listener:443"
#     name      = "SSLPolicy"
#     value     = var.elb_policy_name
#   }

#   dynamic "setting" {
#     for_each = var.elastic_beanstalk_env
#     content {
#       namespace = "aws:elasticbeanstalk:application:environment"
#       name      = setting.key
#       value     = setting.value
#     }
#   }

#   setting {
#     namespace = "aws:elasticbeanstalk:application:environment"
#     name      = "API_ENV"
#     value     = local.env == "prod" ? "production": "staging"
#   }

#   setting {
#     namespace = "aws:rds:dbinstance"
#     name      = "DBAllocatedStorage"
#     value     = "10"
#   }

#   setting {
#     namespace = "aws:rds:dbinstance"
#     name      = "DBDeletionPolicy"
#     value     = "Delete"
#   }

#   setting {
#     namespace = "aws:rds:dbinstance"
#     name      = "HasCoupledDatabase"
#     value     = "true"
#   }

#   setting {
#     namespace = "aws:rds:dbinstance"
#     name      = "DBEngine"
#     value     = "postgres"
#   }

#   setting {
#     namespace = "aws:rds:dbinstance"
#     name      = "DBEngineVersion"
#     value     = "13"
#   }

#   setting {
#     namespace = "aws:rds:dbinstance"
#     name      = "DBInstanceClass"
#     value     = "db.t3.micro"
#   }

#   setting {
#     namespace = "aws:rds:dbinstance"
#     name      = "DBPassword"
#     value     = "foobarbaz"
#   }

#   setting {
#     namespace = "aws:rds:dbinstance"
#     name      = "DBUser"
#     value     = "foo"
#   }

# }

# # data "aws_route53_zone" "selected" {
# #   name = var.hosted_zone
# # }

# # data "aws_elastic_beanstalk_hosted_zone" "this" {}


# # resource "aws_route53_record" "beanstalkappenv" {
# #   zone_id = var.hosted_zone
# #   name    = var.domain_name
# #   type    = "A"

# #   alias {
# #     name                   = aws_cloudfront_distribution.static_website_distribution.domain_name
# #     zone_id                = aws_cloudfront_distribution.static_website_distribution.hosted_zone_id
# #     evaluate_target_health = false
# #   }
# # }