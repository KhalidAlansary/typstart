terraform {
  cloud {
    hostname     = "otaco.app"
    organization = "org_01KDJM8CF9ESDQJ6VV196G1DAD"
    workspaces {
      name = "19dd229d-ce31-41da-a2af-80a260377bb3"
    }
  }
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }
}

resource "cloudflare_pages_project" "typstart" {
  production_branch = "master"
  name              = "typstart"
  account_id        = "e577d53705718821e54be0a2346719a3"
}

resource "cloudflare_zero_trust_access_application" "typstart" {
  name = "typstart"
  destinations = [
    { uri = "*.typstart.pages.dev" }
  ]
  type       = "self_hosted"
  account_id = "e577d53705718821e54be0a2346719a3"
  policies = [{
    decision = "allow"
    include = [{
      email = { email = "khaled.ansary2003@outlook.com" }
    }]
  }]
}
