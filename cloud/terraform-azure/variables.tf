variable "location" {}

variable "prefix" {
  type    = string
  default = "my"
}

variable "tags" {
  type = map

  default = {
    Environment = "Terraform GS"
    Dept        = "Engineering"
  }
}

variable "sku" {
  default = {
    westeurope = "16.04-LTS"
    northeurope  = "18.04-LTS"
  }
}

variable "application_port" {
    description = "The port that you want to expose to the external load balancer"
    default     = 80
}

variable "admin_username" {
    description = "Default username for admin"
    default = "Max"
}

variable "admin_password" {
    description = "Default password for admin"
    default = "Passwwoord11223344"
}

variable "packer_image" {
  description = "Packer Image Name"
  type = string
}