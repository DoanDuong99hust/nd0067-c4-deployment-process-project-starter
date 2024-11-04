# outputs.tf

# output "domain_name" {
#   value = "https://${aws_route53_record.beanstalkappenv.name}/api"
# }

output "website_endpoint" {
  value = aws_s3_bucket_website_configuration.static_website.website_endpoint
}