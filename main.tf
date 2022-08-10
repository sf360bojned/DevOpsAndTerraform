terraform {
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "=3.17.0"
        }
    }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = "b98a54bc-4cf1-41eb-a530-4ee3d7006dd2"
}

resource "azurerm_resource_group" "tf_test" {
    name = "tfmainrg"
    location = "North Europe"
}

resource "azurerm_container_group" "tfcg_test" {
    name                    = "weatherapi"
    location                = azurerm_resource_group.tf_test.location
    resource_group_name     = azurerm_resource_group.tf_test.name

    ip_address_type         = "Public"
    dns_name_label          = "bnedweatherapi"
    os_type                 = "Linux"

    container {
        name        = "weatherapi"
        image       = "bnedeljkovic/weatherapi"
        cpu         = "1"
        memory      = "1"

        ports {
            port        = 80
            protocol    = "TCP"
        }
    }
}