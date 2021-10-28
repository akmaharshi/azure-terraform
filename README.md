# azure-terraform

### provider.tf file content as below:
```
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">=2.0"
    }
  }
}

provider "azurerm" {
  #version = ">=2.0"
  subscription_id = "xxxxxxxx"
  tenant_id       = "xxxxxxxx"
  client_id       = "xxxxxxxx"
  features{}
}
```
