variable "teams" {
  type = map(object({
    description = string
    privacy     = optional(string, "closed")
  }))
  default = {}
}
resource "github_team" "this" {
  for_each    = var.teams
  name        = each.key
  description = each.value.description
  privacy     = each.value.privacy
}
