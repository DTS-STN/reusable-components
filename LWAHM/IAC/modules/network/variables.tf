variable "environment" {
    type = string
    default = "dev"
}
variable "location" {
    type = string
    default = "Canada Central"
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
variable "next_hop_ip" {
  type = string
}
variable "networking_rg" {
    type = string
    default = ""
}
variable "networking_id" {
    type = string
    default = ""
}
variable "networking_rg_name" {
    type = string
    default = ""
}
variable "appgw_vnet_address_space" {
    type = string
}
variable "gateway_capacity" {
    type = number
    default = 1
}
variable "platform" {
    type = string
}