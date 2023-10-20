provider "azurerm" {
  features {}

  subscription_id = "2146ae1f-7d1d-4dbf-828b-54f9ca42f169"
  client_id       = "63751d74-a47a-4236-82da-730543a10243"
  client_secret   = "1I28Q~HcltVrUXdAo.KTQtLMHRhdCQeyeQnj5c4r"
  tenant_id       = "f542f903-8530-4254-aa59-34aa2dcb3bc3"
}

variable "rg" {
    type = list
    default = ["rg1","rg2","rg3"]
}

variable "location" {
    type = list 
    default = ["East US", "West US", "Central US"]
}

resource "azurerm_resource_group" "example" {
    name = element(var.rg,0)
    location = element(var.location,0)
}