provider "azurerm" {
  features {}

  subscription_id = "2146ae1f-7d1d-4dbf-828b-54f9ca42f169"
  client_id       = "63751d74-a47a-4236-82da-730543a10243"
  client_secret   = "1I28Q~HcltVrUXdAo.KTQtLMHRhdCQeyeQnj5c4r"
  tenant_id       = "f542f903-8530-4254-aa59-34aa2dcb3bc3"
}

resource "azurerm_resource_group" "rg" {
    name = "myrg"
    location = "eastus"
}

locals {
    subnets = [
    {    
        name = "mysnet01"
        prefix = "192.168.1.0/24"
    },
    {
        name = "mysnet02"
        prefix = "192.168.2.0/24"
    }
    ]
}

resource "azurerm_virtual_network" "vnet" {
    name = "vnet-westus"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    address_space = ["192.168.0.0/16"]
    dynamic "subnet" {
        for_each = local.subnets
        content {
            name    = subnet.value.name
            address_prefix = subnet.value.prefix
        }
    }
}