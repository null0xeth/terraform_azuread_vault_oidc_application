output "roles" {
  value = azuread_application.vault.oauth2_permission_scope_ids
}

output "object_id" {
  value       = azuread_application.vault.object_id
  sensitive   = true
  description = "Object ID of Azure AD application."
}

output "client_id" {
  value       = azuread_application.vault.client_id
  sensitive   = true
  description = "Client ID of Azure AD application."
}


output "client_secret" {
  value       = azuread_application_password.vault.value
  sensitive   = true
  description = "Client secret of Azure AD application."
}

output "client_secret_id" {
  value       = azuread_application_password.vault.id
  description = "Client secret ID of Azure AD application."
}

output "application_name" {
  value       = azuread_application.vault.display_name
  description = "Display name of Azure AD application."
}

output "tenant_id" {
  value       = var.current_tenant_id
  description = "Tenant ID of Azure subscription."
}

output "application_uri" {
  value       = azuread_application.vault.identifier_uris
  description = "Configured Application ID URIs of Azure AD application."
}
