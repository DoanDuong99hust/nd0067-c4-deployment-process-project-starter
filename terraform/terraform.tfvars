# terraform.tfvars
project_name = "uda-fullstack-app"
hosted_zone = "udafullstackapp.demo.com"
region = "us-east-1"
instance_type       = "t2.micro"
minsize             = 1
maxsize             = 4
tier = "WebServer"
solution_stack_name= "64bit Amazon Linux 2023 v6.2.2 running Node.js 18"
certificate_arn = "arn:aws:acm:region:account-id:certificate/certificate-id"

elastic_beanstalk_env = {
  "KEY" = "VALUE"
}

repository_id = "nedssoft/repository-name"
branch_name = "master"
repository_url = "https://github.com/DoanDuong99hust/nd0067-c4-deployment-process-project-starter.git"
domain_name = "udafullstackapp.demo.com"
