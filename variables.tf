#### DATA MODULE: #######
variable "azurerm_sub_id" {
  type        = string
  default     = null
  description = "SYSTEM GENERATED: the current Azurerm subscription ID"
}

variable "directory_role_templates" {
  type        = any
  default     = null
  description = "SYSTEM GENERATED: map containing AzureAD directory role templates"

}

variable "current_tenant_id" {
  type        = string
  default     = null
  description = "SYSTEM GENERATED: the current AzureAD tenant ID"

}

variable "current_client_object_id" {
  type        = string
  default     = null
  description = "SYSTEM GENERATED: the current AzureAD client object ID"

}

variable "msgraph_resource_id" {
  type        = string
  default     = null
  description = "SYSTEM GENERATED: the resource object ID of the MSGraph API"
}

variable "msgraph_role_ids" {
  default     = null
  type        = any
  description = "SYSTEM GENERATED: map with assignable MSGraph roles"
}
##########################

variable "oidc_redirect_uris" {
  default     = []
  description = "List with URIs the OIDC application will redirect to"
  type        = list(string)
}

variable "azuread_vault_role" {
  default     = {}
  description = "AzureAD RBAC role configuration"
  type = object({
    actions     = optional(list(string), ["*"])
    not_actions = optional(list(string), [])
  })
}

variable "azuread_oidc_application" {
  default     = {}
  description = "AzureAD OIDC application configuration"
  type = object({
    app_audience    = optional(string, "AzureADMyOrg")
    group_claims    = optional(list(string), ["All"])
    vault_id_prefix = optional(string, "vault-id")
    role_template   = optional(string, "Cloud Application Administrator")
  })
}

variable "azuread_oidc_app_roles" {
  description = "List of objects containing OIDC Application roles"
  default     = []
  type = list(object({
    allowed_member_types = optional(list(string))
    description          = optional(string)
    enabled              = optional(bool)
    display_name         = optional(string)
    id                   = optional(string)
    value                = optional(string)
  }))
}

variable "azuread_oidc_claims" {
  default     = {}
  description = "AzureAD OIDC Optional claim configuration"
  type = object({
    access_token = optional(string, "groups")
    id_token     = optional(string, "groups")
    saml_token   = optional(string, "groups")
  })
}

variable "azuread_oidc_permission_scope" {
  default     = {}
  description = "AzureAD OIDC Application permission scoping and config."
  type = object({
    admin_description  = optional(string, "Allow the application to access gated resources on behalf of the signed-in user.")
    admin_display_name = optional(string, "Vault Guardian")
    enabled            = optional(bool, true)
    template_user_id   = optional(string, "0c9a07ff-70d5-46e3-a995-d072f0696d20")
    type               = optional(string, "Admin")
    value              = optional(string, "admin")
  })
}

variable "azuread_oidc_resource_roles" {
  description = "List of objects containing requested resource RBAC roles"
  type = list(object({
    id   = optional(string)
    type = optional(string)
  }))
  default = [
    {
      id   = "GroupMember.Read.All"
      type = "Role"
    },
    {
      id   = "Group.Read.All"
      type = "Role"
    },
    {
      id   = "User.Read.All"
      type = "Role"
  }]
}
