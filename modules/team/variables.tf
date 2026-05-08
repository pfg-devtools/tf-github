variable "name" { type = string }
variable "description" { type = string }
variable "maintainers" {
  type    = list(string)
  default = []
}
