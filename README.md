# tf-cognito

Terraform configuration for AWS Cognito authentication infrastructure.

## Overview

This repository manages AWS Cognito User Pool configuration for authentication services, including:

- User pool with MFA enforcement
- Custom domain with SSL certificates  
- UI customization with logo
- User management and groups
- Integration with SES for email notifications

## Dependencies

- **tf-aws**: For SES configuration and account information
- **tf-cloudflare**: For DNS zone management and certificate validation

## Resources Created

- AWS Cognito User Pool with MFA enabled
- Cognito User Pool Domain (both default and custom)
- ACM Certificate for custom domain (in us-east-1)
- Cloudflare DNS records for certificate validation and domain
- IAM Service Linked Role for Cognito email
- Cognito users and groups
- UI customization with logo

## Usage

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

## Configuration

The user pool is configured with:
- Email-based authentication
- MFA enforcement with software tokens
- Custom password policy
- Email recovery mechanism
- Custom UI with logo
- Integration with SES for email delivery

## Outputs

- `auth_user_pool_id`: The ID of the Cognito User Pool
- `auth_user_pool_endpoint`: The endpoint of the Cognito User Pool
