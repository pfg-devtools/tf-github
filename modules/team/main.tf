resource "github_team" "this" {
  name        = var.name
  description = var.description
  privacy     = "closed"
}
resource "github_team_membership" "maintainers" {
  for_each = toset(var.maintainers)
  team_id  = github_team.this.id
  username = each.value
  role     = "maintainer"
}
