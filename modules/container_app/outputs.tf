output "storage_account_ids" {
  value = { for account in var.storage_accounts : account.name => azurerm_storage_account.this[account.name].id }
}

