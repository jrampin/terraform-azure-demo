variable "location" {
  type    = string
  default = "australiasoutheast"
}

variable "project_name" {
  type    = string
  default = "azure-training"
}

variable "environment" {
  type    = string
  default = "demo"
}

variable "ssh-source-address" {
  type    = string
  default = "*"
}