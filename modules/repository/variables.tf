variable "name" { type = string }
variable "description" {
  type    = string
  default = ""
}
variable "visibility" {
  type    = string
  default = "private"
}
variable "topics" {
  type    = list(string)
  default = []
}
