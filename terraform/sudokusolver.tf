terraform {
  backend "azurerm" {
    resource_group_name  = "VstsRG-malevy-6808"
    storage_account_name = "vstsrgmalevy6808sa"
    container_name       = "terraform-state"
    key                  = "sudoku-solver-tf-state"
  }
}

provider "azurerm" {
  version = "~>2.10.0"
  features {}
}

# azurerm_resource_group.sudokusolver-rg:
resource "azurerm_resource_group" "sudokusolver-rg" {
  location     = "eastus2"
  name         = "sudokusolver-rg"
  tags         = {
  "foo" = "bar"
  }
}    
# azurerm_app_service_plan.sudoku-solver-plan:
resource "azurerm_app_service_plan" "sudoku-solver-plan" {
  is_xenon                         = false
  kind                             = "App"
  location                         = azurerm_resource_group.sudokusolver-rg.location
  maximum_elastic_worker_count     = 1
  name                             = "sudoku-solver-plan"
  per_site_scaling                 = false
  reserved                         = false
  resource_group_name              = azurerm_resource_group.sudokusolver-rg.name

  sku {
          capacity     = 1
          size         = "S1"
          tier         = "Standard"
  }
}    
# azurerm_app_service.sudoku-solver:
resource "azurerm_app_service" "sudoku-solver" {
  app_service_plan_id                = azurerm_app_service_plan.sudoku-solver-plan.id
  app_settings                       = {
  "WEBSITE_NODE_DEFAULT_VERSION" = "6.9.1"
  }
  client_affinity_enabled            = true
  client_cert_enabled                = false
  enabled                            = true
  https_only                         = false
  location                           = azurerm_resource_group.sudokusolver-rg.location
  name                               = "sudoku-solver"
  resource_group_name                = azurerm_resource_group.sudokusolver-rg.name

  auth_settings {
          additional_login_params            = {}
          allowed_external_redirect_urls     = []
          enabled                            = false
          token_refresh_extension_hours      = 0
          token_store_enabled                = false
  }

  logs {
      http_logs {
          file_system {
                  retention_in_days     = 5
                  retention_in_mb       = 35
          }
      }
  }

  site_config {
    always_on                     = false
    dotnet_framework_version      = "v4.0"
    ftps_state                    = "AllAllowed"
    http2_enabled                 = false
    ip_restriction                = []
    local_mysql_enabled           = false
    managed_pipeline_mode         = "Integrated"
    min_tls_version               = "1.2"
    remote_debugging_enabled      = false
    remote_debugging_version      = "VS2019"
    scm_type                      = "VSTSRM"
    use_32_bit_worker_process     = true
    websockets_enabled            = false

    cors {
            allowed_origins         = []
            support_credentials     = false
    }
  }
}    
# azurerm_app_service_slot.staging-slot:
resource "azurerm_app_service_slot" "staging-slot" {
  app_service_name            = azurerm_app_service.sudoku-solver.name
  app_service_plan_id         = azurerm_app_service_plan.sudoku-solver-plan.id
  app_settings                = {
  "WEBSITE_NODE_DEFAULT_VERSION" = "6.9.1"
  }
  client_affinity_enabled     = true
  enabled                     = true
  https_only                  = false
  location                    = azurerm_resource_group.sudokusolver-rg.location
  name                        = "STAGING"
  resource_group_name         = azurerm_resource_group.sudokusolver-rg.name

  auth_settings {
    additional_login_params            = {}
    allowed_external_redirect_urls     = []
    enabled                            = false
    token_refresh_extension_hours      = 0
    token_store_enabled                = false
  }

  site_config {
    always_on                     = false
    dotnet_framework_version      = "v4.0"
    ftps_state                    = "AllAllowed"
    http2_enabled                 = false
    ip_restriction                = []
    local_mysql_enabled           = false
    managed_pipeline_mode         = "Integrated"
    min_tls_version               = "1.2"
    remote_debugging_enabled      = false
    remote_debugging_version      = "VS2019"
    scm_type                      = "VSTSRM"
    use_32_bit_worker_process     = true
    websockets_enabled            = false

    cors {
      allowed_origins         = []
      support_credentials     = false
    }
  }
}    
