provider "azurerm" {
  features {}

  subscription_id = "2146ae1f-7d1d-4dbf-828b-54f9ca42f169"
  client_id       = "63751d74-a47a-4236-82da-730543a10243"
  client_secret   = "1I28Q~HcltVrUXdAo.KTQtLMHRhdCQeyeQnj5c4r"
  tenant_id       = "f542f903-8530-4254-aa59-34aa2dcb3bc3"
}


resource "azurerm_resource_group" "example" {
  name     = "KIBB-RG"
  location = "southeastasia"
}

resource "azurerm_virtual_network" "myvnet01" {
  name                = "myvnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "mysubnet01" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.myvnet01.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "example" {
  name                = "myPublicIP"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "mynic01" {
  name                = "myKIBB-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                 = azurerm_subnet.mysubnet01.id
    private_ip_address_allocation     = "Dynamic"
    public_ip_address_id    = azurerm_public_ip.example.id
  }
}

resource "azurerm_windows_virtual_machine" "myVM01" {
  name                = "myVM01"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.mynic01.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}