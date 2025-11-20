resource "aws_cognito_user" "melvyn" {
  user_pool_id       = aws_cognito_user_pool.auth.id
  username           = "melvyn@mdekort.nl"
  temporary_password = "Welkom!23"

  attributes = {
    email          = "melvyn@mdekort.nl"
    email_verified = true
    family_name    = "de Kort"
    given_name     = "Melvyn"
    name           = "Melvyn de Kort"
  }
}

resource "aws_cognito_user_group" "admins" {
  user_pool_id = aws_cognito_user_pool.auth.id
  name         = "admins"
  precedence   = 1
  description  = "Administrator group"
}

resource "aws_cognito_user_in_group" "admins_melvyn" {
  user_pool_id = aws_cognito_user_pool.auth.id
  group_name   = aws_cognito_user_group.admins.name
  username     = aws_cognito_user.melvyn.username
}
