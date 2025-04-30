variable "environment" {
  type    = string
  default = "dev"
}
variable "location" {
  type    = string
}
variable "base_domain" {
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
variable "application_name" {
  type = string
}
variable "app_service_sku" {
  type = string
}
variable "kv_uri" {
  type = string
}
variable "kv_id" {
  type = string
}
variable "private_dns_rg" {
  type = string
}
variable "networking_rg_name" {
  type = string
}
variable "privatelink_dns_name" {
  type = string
}
variable "privatelink_dns_id" {
  type = string
}
variable "snet_peps_id" {
  type = string
}
variable "snet_app_service_id" {
  type = string
}
variable "law_id" {
  type = string
}
variable "image_name" {
  type = string
}
variable "image_tag" {
  type = string
}
variable "int_image_tag" {
  type = string
}
variable "acr_id" {
  type = string
}
variable email_receivers {
  type        = list(object({
    name = string,
    email = string 
  }))
}
variable "platform" {
  type = string
}
