variable "environment" {
  type    = string
  default = "dev"
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
variable "private_dns_rg" {
  type = string
}
variable "platform_vnet_id" {
  type = string
}
variable "esdc_hub_peered_vnet_id" {
  type = string
}
variable "platform" {
    type = string
}