resource "aws_cognito_user_pool" "auth" {
  name                = "mdekort-auth"
  username_attributes = ["email"]
  mfa_configuration   = "ON"

  admin_create_user_config {
    allow_admin_create_user_only = true
  }

  software_token_mfa_configuration {
    enabled = true
  }

  email_configuration {
    email_sending_account = "DEVELOPER"
    from_email_address    = var.noreply_email
    # The SES identity is the verified domain (mdekort.nl); there is no
    # separate noreply@ email identity, and Cognito's UpdateUserPool fails with
    # "Email address is not verified" when source_arn points at one.
    source_arn = "arn:aws:ses:${var.aws_region}:${data.aws_caller_identity.current.account_id}:identity/${split("@", var.noreply_email)[1]}"
  }

  schema {
    name                     = "email"
    attribute_data_type      = "String"
    required                 = true
    developer_only_attribute = false

    mutable = false

    string_attribute_constraints {
      min_length = 0
      max_length = 2048
    }
  }

  schema {
    name                     = "family_name"
    attribute_data_type      = "String"
    required                 = false
    developer_only_attribute = false

    mutable = true

    string_attribute_constraints {
      min_length = 0
      max_length = 2048
    }
  }

  schema {
    name                     = "given_name"
    attribute_data_type      = "String"
    required                 = false
    developer_only_attribute = false

    mutable = true

    string_attribute_constraints {
      min_length = 0
      max_length = 2048
    }
  }

  schema {
    name                     = "name"
    attribute_data_type      = "String"
    required                 = false
    developer_only_attribute = false

    mutable = true

    string_attribute_constraints {
      min_length = 0
      max_length = 2048
    }
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  password_policy {
    minimum_length                   = 8
    require_lowercase                = true
    require_numbers                  = true
    require_symbols                  = true
    require_uppercase                = true
    temporary_password_validity_days = 7
  }
}

resource "aws_iam_service_linked_role" "cognito-email" {
  aws_service_name = "email.cognito-idp.amazonaws.com"
}

resource "aws_cognito_user_pool_ui_customization" "auth" {
  user_pool_id = aws_cognito_user_pool_domain.auth.user_pool_id
  image_file   = filebase64("${path.module}/assets/mdekort-logo.png")
}

resource "aws_cognito_user_pool_domain" "auth" {
  domain       = "mdekort"
  user_pool_id = aws_cognito_user_pool.auth.id
}
