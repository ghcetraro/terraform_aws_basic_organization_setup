#
account     = "pepe-argento"
account_id  = "1234567890"
environment = "production"
region      = "us-east-1"
role        = "default"
project     = "terraform"
#
#
#
ous = [
  "development",
  "staging",
  "production"
]
#
list_of_accounts_ids = {
  development = "1234567890"
  staging     = "0987654321"
  production  = "5432109876"
}
#
member_accounts = {
  "development" = {
    name              = "development"
    email             = "development@pepe.com"
    ou_name           = "development"
    close_on_deletion = false
  },
  "staging" = {
    name              = "staging"
    email             = "staging@pepe.com"
    ou_name           = "staging"
    close_on_deletion = false
  },
  "production" = {
    name              = "production"
    email             = "production@pepe.com"
    ou_name           = "production"
    close_on_deletion = false
  },
}
#
users = {
  # admin
  "juan.pepe" = {
    email    = "juan.pepe@pepe.com"
    name     = "juan"
    lastname = "pepe"
  },
  # devs
  "predro.pepe" = {
    email    = "predro.pepe@pepe.com"
    name     = "predro"
    lastname = "pepe"
  }
  # qas
  "jose.pepe" = {
    email    = "jose.pepe@pepe.com"
    name     = "jose"
    lastname = "pepe"
  },
}
#
grupos = [
  "admin",
  "developers",
  "staging",
]
#
users_to_groups = [
  {
    group = "admin",
    value = [
      "juan.pepe"
    ]
  },
  {
    group = "developers",
    value = [
      "predro.pepe",
    ]
  },
  {
    group = "staging",
    value = [
      "jose.pepe",
    ]
  },
]
#
permission_set = [
  "admin",
  "developers",
  "staging",
]
#