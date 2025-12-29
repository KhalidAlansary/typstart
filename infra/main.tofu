terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }
}

variable "cloudflare_account_id" {
  description = "Cloudflare Account ID"
  type        = string
}

variable "project_name" {
  description = "Project name for Cloudflare Pages"
  type        = string
  default     = "typstart"
}

resource "cloudflare_pages_project" "typstart" {
  production_branch = "master"
  name              = var.project_name
  account_id        = var.cloudflare_account_id
}

# Uncomment the "zero_trust_access_policy" and the "zero_trust_access_application" blocks
# below if you want the site to be publicly accessible.

# # Only allow access to specific email addresses
# resource "cloudflare_zero_trust_access_policy" "private-site-policy" {
#   account_id = var.cloudflare_account_id
#   name       = "Private Site Access Policy"
#   decision   = "allow"
#   include = [
#     { email = { email = "khaled.ansary2003@outlook.com" } },
#   ]
# }
#
# # Make the Cloudflare Pages project accessible only via Zero Trust Access Application
# resource "cloudflare_zero_trust_access_application" "typstart-app" {
#   name = "${var.project_name} - Cloudflare Pages"
#   destinations = [
#     # NOTE: Change this if the subdomain given by Cloudflare Pages is different than the project name
#     { uri = "${var.project_name}.pages.dev" },
#     { uri = "*.${var.project_name}.pages.dev" }
#   ]
#   type       = "self_hosted"
#   account_id = var.cloudflare_account_id
#   policies = [{
#     id = cloudflare_zero_trust_access_policy.private-site-policy.id
#   }]
# }
