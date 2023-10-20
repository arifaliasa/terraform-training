provider "azurerm" {
  features {}

  subscription_id = "2146ae1f-7d1d-4dbf-828b-54f9ca42f169"
  client_id       = "63751d74-a47a-4236-82da-730543a10243"
  client_secret   = "1I28Q~HcltVrUXdAo.KTQtLMHRhdCQeyeQnj5c4r"
  tenant_id       = "f542f903-8530-4254-aa59-34aa2dcb3bc3"
}

resource "azurerm_managed_disk" "example" {
    create_option                     = "Empty"
    #disk_iops_read_only               = 0
    #disk_iops_read_write              = 120
    #disk_mbps_read_only               = 0
    #disk_mbps_read_write              = 25
    disk_size_gb                      = 64
    location                          = "eastus"
    #max_shares                        = 0
    name                              = "datadisk1"
    on_demand_bursting_enabled        = false
    optimized_frequent_attach_enabled = false
    performance_plus_enabled          = false
    public_network_access_enabled     = true
    resource_group_name               = "WebApp3133_group"
    storage_account_type              = "Premium_LRS"
    tags                              = {}
    tier                              = "P6"
    trusted_launch_enabled            = false
    #upload_size_bytes                 = 0
    zone                              = "3"
}

resource "azurerm_linux_virtual_machine" "example" {
    admin_password                                         = "P@ssw0rd1234"
    admin_username                                         = "adminroot"
    allow_extension_operations                             = true
    bypass_platform_safety_checks_on_user_schedule_enabled = false
    computer_name                                          = "kalitestvm01"
    disable_password_authentication                        = false
    encryption_at_host_enabled                             = false
    extensions_time_budget                                 = "PT1H30M"
    location                                               = "eastus"
    max_bid_price                                          = -1
    name                                                   = "kalitestvm01"
    network_interface_ids                                  = [
        "/subscriptions/2146ae1f-7d1d-4dbf-828b-54f9ca42f169/resourceGroups/WebApp3133_group/providers/Microsoft.Network/networkInterfaces/kalitestvm01128_z1",
    ]
    patch_assessment_mode                                  = "ImageDefault"
    patch_mode                                             = "ImageDefault"
    #platform_fault_domain                                  = -1
    priority                                               = "Regular"
    #private_ip_address                                     = "10.0.0.4"
    #private_ip_addresses                                   = [
    #    "10.0.0.4",
    #]
    provision_vm_agent                                     = true
    #public_ip_address                                      = "172.174.124.184"
    resource_group_name                                    = "WebApp3133_group"
    secure_boot_enabled                                    = false
    size                                                   = "Standard_DS1_v2"
    tags                                                   = {}
    #virtual_machine_id                                     = "a3be80fb-ab2b-4df5-ba37-ee713f757e8e"
    vtpm_enabled                                           = false
    zone                                                   = "3"

    boot_diagnostics {}

    os_disk {
        caching                   = "ReadWrite"
        disk_size_gb              = 40
        name                      = "kalitestvm01_OsDisk_1_9fc856b718cf4151bef0c7227d9eab85"
        storage_account_type      = "Premium_LRS"
        write_accelerator_enabled = false
    }

    plan {
        name      = "kali-2023-3"
        product   = "kali"
        publisher = "kali-linux"
    }

    source_image_reference {
        offer     = "kali"
        publisher = "kali-linux"
        sku       = "kali-2023-3"
        version   = "latest"
    }
}


resource "azurerm_resource_group" "example" {
    location = "westeurope"
    name     = "kibb02-rg"
    tags     = {}

}

resource "azurerm_windows_web_app" "example" {
    app_settings                      = {
        "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    }
    client_affinity_enabled           = false
    client_certificate_enabled        = false
    client_certificate_mode           = "Required"
    #custom_domain_verification_id     = "9633B3768A2770681F1DF924F9C4DB41CB6422CD13AA4B26A24A5B4F2534DD97"
    #default_hostname                  = "webapp3133.azurewebsites.net"
    enabled                           = true
    https_only                        = true
    #key_vault_reference_identity_id   = "SystemAssigned"
    #kind                              = "app,container,windows"
    location                          = "eastus"
    name                              = "WebApp3133"
    public_network_access_enabled     = true
    resource_group_name               = "WebApp3133_group"
    service_plan_id                   = "/subscriptions/2146ae1f-7d1d-4dbf-828b-54f9ca42f169/resourceGroups/WebApp3133_group/providers/Microsoft.Web/serverfarms/ASP-WebApp3133group-b79e"
    #site_credential                   = (sensitive value)
    tags                              = {}

    site_config {
        always_on                               = true
        #auto_heal_enabled                       = false
        container_registry_use_managed_identity = false
        default_documents                       = [
            "Default.htm",
            "Default.html",
            "Default.asp",
            "index.htm",
            "index.html",
            "iisstart.htm",
            "default.aspx",
            "index.php",
            "hostingstart.html",
        ]
        #detailed_error_logging_enabled          = false
        ftps_state                              = "FtpsOnly"
        health_check_eviction_time_in_min       = 10
        http2_enabled                           = false
        load_balancing_mode                     = "LeastRequests"
        local_mysql_enabled                     = false
        managed_pipeline_mode                   = "Integrated"
        minimum_tls_version                     = "1.2"
        remote_debugging_enabled                = false
        scm_minimum_tls_version                 = "1.2"
        #scm_type                                = "None"
        scm_use_main_ip_restriction             = false
        use_32_bit_worker                       = true
        vnet_route_all_enabled                  = false
        websockets_enabled                      = false
        #windows_fx_version                      = "DOCKER|mcr.microsoft.com/azure-app-service/windows/parkingpage:latest"
        worker_count                            = 1

        application_stack {
            docker_image_name            = "azure-app-service/windows/parkingpage:latest"
            docker_registry_url          = "https://mcr.microsoft.com"
            #java_embedded_server_enabled = false
            php_version                  = "Off"
            python                       = false
        }
    }
}

resource "azurerm_app_service_plan" "example" {
    is_xenon                     = true
    kind                         = "windows"
    location                     = "eastus"
    maximum_elastic_worker_count = 1
    #maximum_number_of_workers    = 30
    name                         = "ASP-WebApp3133group-b79e"
    per_site_scaling             = false
    reserved                     = false
    resource_group_name          = "WebApp3133_group"
    tags                         = {}
    zone_redundant               = false

    sku {
        capacity = 1
        size     = "P1mv3"
        tier     = "PremiumMV3"
    }
}
