# tf-cognito

> For global standards, way-of-workings, and pre-commit checklist, see `~/.kiro/steering/behavior.md`

## Role

Cloud Engineer specializing in Terraform and AWS Cognito.

## Important Notes

- This repo has NO Makefile and NO local encrypted secrets
- Uses two AWS provider aliases: default (eu-west-1) and `useast1` (us-east-1) — Cognito custom domains require us-east-1 certificates
- Cloudflare API token comes from `tf-cloudflare` remote state

## Repository Structure

- `terraform/user-pool.tf` — Cognito User Pool with MFA enforcement
- `terraform/cognito-users.tf` — User and group management
- `terraform/domain.tf` — Custom domain with UI customization
- `terraform/certificates.tf` — ACM certificates (us-east-1)
- `terraform/outputs.tf` — User pool ID and endpoint
- `terraform/remote-state.tf` — References tf-cloudflare and tf-aws

## Outputs Consumed by Other Repos

- `tf-grafana` — User pool ID/endpoint for Grafana SSO

## Terraform Details

- Backend: S3 key `tf-cognito.tfstate` in `mdekort-tfstate-075673041815`
- Providers: AWS `~> 6.0`, Cloudflare `~> 5.0`

## Related Repositories

- `~/src/melvyndekort/tf-aws` — AWS account management, SES configuration
- `~/src/melvyndekort/tf-cloudflare` — Provides API token for DNS validation
- `~/src/melvyndekort/tf-grafana` — Consumes Cognito outputs for SSO
