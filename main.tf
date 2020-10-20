data "azuread_user" "user" {
  user_principal_name = var.user
}


resource "azurerm_key_vault" "keyvault" {
  name                        = var.vault_name
  location                    = var.region
  resource_group_name         = var.rg
  tenant_id                   = var.tenant_id
  soft_delete_enabled         = true
  sku_name                    = "standard"

  access_policy {
    tenant_id = var.tenant_id
    object_id = data.azuread_user.user.id

    key_permissions = [
      "get", "list", "update", "create", "import", "delete", "recover", "backup", "restore"
    ]

    secret_permissions = [
      "get", "list", "set", "delete", "recover", "backup", "restore"
    ]

    storage_permissions = [
      "get", "list", "update", "set", "delete", "recover", "backup", "restore"
    ]
  }

  tags = {
    BillingIndicator      = var.bill_indicator_tag
    CompanyCode           = var.company_code_tag  
    EnvironmentType       = var.env_tag           
    ConsumerOrganization1 = var.consumer_org1_tag 
    ConsumerOrganization2 = var.consumer_org2_tag
    SupportStatus         = var.support_stat_tag  
  }
}
