###### Generate a random App ID: ######
resource "random_id" "app" {
  byte_length = 4
}

resource "random_uuid" "rand" {}

locals {
  desired_role_template = [for role in var.directory_role_templates : role if role.display_name == "${var.azuread_oidc_application.role_template}"]
  desired_role_id       = local.desired_role_template[*].object_id
  display_name          = "${var.azuread_oidc_application.vault_id_prefix}-${random_id.app.hex}"
}


resource "azuread_application" "vault" {
  display_name            = local.display_name
  identifier_uris         = ["api://${local.display_name}"]
  owners                  = [var.current_client_object_id]
  sign_in_audience        = var.azuread_oidc_application.app_audience
  group_membership_claims = var.azuread_oidc_application.group_claims
  prevent_duplicate_names = true

  api {
    requested_access_token_version = 2
    mapped_claims_enabled          = true
    oauth2_permission_scope {
      admin_consent_description  = var.azuread_oidc_permission_scope.admin_description
      admin_consent_display_name = var.azuread_oidc_permission_scope.admin_display_name
      enabled                    = var.azuread_oidc_permission_scope.enabled
      id                         = var.current_client_object_id
      type                       = var.azuread_oidc_permission_scope.type
      value                      = var.azuread_oidc_permission_scope.value
    }
  }

  dynamic "app_role" {
    for_each = var.azuread_oidc_app_roles
    content {
      allowed_member_types = app_role.value["allowed_member_types"]
      description          = app_role.value["description"]
      display_name         = app_role.value["display_name"]
      enabled              = app_role.value["enabled"]
      id                   = app_role.value["id"]
      value                = app_role.value["value"]
    }
  }

  optional_claims {
    access_token {
      name = var.azuread_oidc_claims.access_token
    }

    id_token {
      name = var.azuread_oidc_claims.id_token
    }

    saml2_token {
      name = var.azuread_oidc_claims.saml_token
    }
  }

  required_resource_access {
    resource_app_id = var.msgraph_resource_id

    dynamic "resource_access" {
      for_each = var.azuread_oidc_resource_roles
      content {
        id   = var.msgraph_role_ids[resource_access.value["id"]]
        type = resource_access.value["type"]
      }
    }
  }

  web {
    redirect_uris = var.oidc_redirect_uris

    implicit_grant {
      id_token_issuance_enabled     = true
      access_token_issuance_enabled = true
    }
  }
}

resource "azuread_service_principal" "vault" {
  client_id = azuread_application.vault.client_id
  owners    = [var.current_client_object_id]
}

resource "azuread_directory_role" "cloud_application_administrator" {
  template_id = element(local.desired_role_id, 0) # Cloud Application Administrator
}

resource "azurerm_role_definition" "vault_role" {
  name        = random_uuid.rand.result
  scope       = var.azurerm_sub_id
  description = "This is role for App registrations used for HashiCorp Vault."

  permissions {
    actions     = var.azuread_vault_role.actions
    not_actions = var.azuread_vault_role.not_actions
  }

  assignable_scopes = [
    var.azurerm_sub_id
  ]
}

resource "azurerm_role_assignment" "vault_role" {
  name               = random_uuid.rand.result
  scope              = var.azurerm_sub_id
  role_definition_id = azurerm_role_definition.vault_role.role_definition_resource_id
  principal_id       = azuread_service_principal.vault.object_id
}

resource "azuread_application_password" "vault" {
  display_name   = "Vault"
  application_id = "/applications/${azuread_application.vault.object_id}"
}
