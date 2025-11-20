resource "aws_cognito_user_pool_domain" "auth-custom" {
  domain          = aws_acm_certificate.auth.domain_name
  certificate_arn = aws_acm_certificate_validation.auth.certificate_arn
  user_pool_id    = aws_cognito_user_pool.auth.id
}

resource "cloudflare_dns_record" "auth" {
  zone_id = data.terraform_remote_state.tf_cloudflare.outputs.mdekort_zone_id
  name    = aws_acm_certificate.auth.domain_name
  type    = "CNAME"
  ttl     = 1
  proxied = true
  content = aws_cognito_user_pool_domain.auth-custom.cloudfront_distribution_arn
}
