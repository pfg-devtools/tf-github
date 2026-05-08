terraform {
  required_version = ">= 1.6"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}
module "platform" {
  source      = "../../modules/team"
  name        = "platform"
  description = "Platform engineering"
}
module "actions" {
  source      = "../../modules/repository"
  name        = "actions"
  description = "Reusable GitHub Actions"
  visibility  = "public"
  topics      = ["github-actions", "ci"]
}
