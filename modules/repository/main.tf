resource "github_repository" "this" {
  name                   = var.name
  description            = var.description
  visibility             = var.visibility
  delete_branch_on_merge = true
  vulnerability_alerts   = true
  topics                 = var.topics
}
resource "github_branch_protection" "main" {
  repository_id = github_repository.this.node_id
  pattern       = "main"
  required_pull_request_reviews {
    required_approving_review_count = 1
  }
}
