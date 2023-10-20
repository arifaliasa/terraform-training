provider "azurerm" {
  features {}

  subscription_id = "2146ae1f-7d1d-4dbf-828b-54f9ca42f169"
  client_id       = "63751d74-a47a-4236-82da-730543a10243"
  client_secret   = "1I28Q~HcltVrUXdAo.KTQtLMHRhdCQeyeQnj5c4r"
  tenant_id       = "f542f903-8530-4254-aa59-34aa2dcb3bc3"
}

resource "azurerm_resource_group" "example" {
  name     = "piprg"
  location = "West Europe"
}

resource "azurerm_public_ip" "example" {
  name                = "myip${count.index}"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allocation_method   = "Static"
  count = 3
}

output "name" {
    value = zipmap(azurerm_public_ip.example[*].name,azurerm_public_ip.example[*].ip_address)
}