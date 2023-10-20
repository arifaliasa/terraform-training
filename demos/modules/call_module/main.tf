provider "azurerm" {
  features {}

  subscription_id = "2146ae1f-7d1d-4dbf-828b-54f9ca42f169"
  client_id       = "63751d74-a47a-4236-82da-730543a10243"
  client_secret   = "1I28Q~HcltVrUXdAo.KTQtLMHRhdCQeyeQnj5c4r"
  tenant_id       = "f542f903-8530-4254-aa59-34aa2dcb3bc3"
}

module "xyz" {
    source = "../vm_resource"
    rg_name = "kibb-rg"
    vnet_name = "kibb-vnet"
    subnet_name = "kibb-subnet"
    nic_name = "kibb-nic"
    vm_name = "kibb-vm"
}