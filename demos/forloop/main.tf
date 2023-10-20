provider "azurerm" {
  features {}

  subscription_id = "2146ae1f-7d1d-4dbf-828b-54f9ca42f169"
  client_id       = "63751d74-a47a-4236-82da-730543a10243"
  client_secret   = "1I28Q~HcltVrUXdAo.KTQtLMHRhdCQeyeQnj5c4r"
  tenant_id       = "f542f903-8530-4254-aa59-34aa2dcb3bc3"
}

variable "groups" {
  type = map
  default = {
    dev = "eastus"
    prod = "centralus"
    
  }
}

resource "azurerm_resource_group" "rg" {
  for_each = var.groups
  name     = each.key
  location = each.value
}