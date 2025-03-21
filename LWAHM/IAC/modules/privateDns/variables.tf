variable "environment" {
  type    = string
  default = "dev"
}
variable "location" {
  type    = string
  default = "Canada Central"
}
variable "base_domain" {
  type    = string
  default = ""
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
variable "object_id" {
  type = string
}
variable "dns_rg_name" {
  type    = string
  default = ""
}
variable "client_secret" {
  type = string
}
variable "application_name" {
  type    = string
  default = "test-app"
}
variable "application_rg_name" {
  type    = string
  default = ""
}
variable "domain_verification_id" {
  type    = string
  default = ""
}
variable "app_service_id" {
  type    = string
  default = ""
}
variable "environment_domain_name" {
  type = string
}
variable "wildcard_ssl_certificate_password" {
  type = string
}
variable "private_dns_rg" {
  type = string
}
variable "lwhp_vnet_id" {
  type = string
}
variable "esdc_hub_peered_vnet_id" {
  type = string
}