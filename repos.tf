variable "repos" {
  type = map(object({
    description = optional(string, "")
    visibility  = optional(string, "private")
  }))
  default = {}
}
resource "github_repository" "this" {
  for_each    = var.repos
  name        = each.key
  description = each.value.description
  visibility  = each.value.visibility
}
