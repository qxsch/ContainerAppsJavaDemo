output "dapr_storage_account_ids" {
  value = { for account in var.dapr_storage_accounts : account.name => azurerm_storage_account.dapr[account.name].id }
}

output "linked_storage_account_ids" {
  value = { for account in var.linked_storage_accounts : account.name => azurerm_storage_account.linked[account.name].id }
}
