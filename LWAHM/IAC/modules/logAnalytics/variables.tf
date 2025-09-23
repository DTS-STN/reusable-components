variable "environment" {
  type    = string
  default = "dev"
}
variable "location" {
  type    = string
}
variable "subscription_id" {
  type = string
}
variable "tenant_id" {
  type = string
}
variable "client_id" {
  type = string
}
variable "client_secret" {
  type = string
}
variable "log_rg_name" {
  type = string
}
variable "retention_days" {
  type = number
}
variable "platform" {
    type = string
}