<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~>2.53.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 4.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | ~>2.53.1 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.3.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_application.vault](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application_password.vault](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_password) | resource |
| [azuread_directory_role.cloud_application_administrator](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/directory_role) | resource |
| [azuread_service_principal.vault](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azurerm_role_assignment.vault_role](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/resources/role_assignment) | resource |
| [azurerm_role_definition.vault_role](https://registry.terraform.io/providers/hashicorp/azurerm/4.3.0/docs/resources/role_definition) | resource |
| [random_id.app](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_uuid.rand](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azuread_oidc_app_roles"></a> [azuread\_oidc\_app\_roles](#input\_azuread\_oidc\_app\_roles) | List of objects containing OIDC Application roles | <pre>list(object({<br>    allowed_member_types = optional(list(string))<br>    description          = optional(string)<br>    enabled              = optional(bool)<br>    display_name         = optional(string)<br>    id                   = optional(string)<br>    value                = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_azuread_oidc_application"></a> [azuread\_oidc\_application](#input\_azuread\_oidc\_application) | AzureAD OIDC application configuration | <pre>object({<br>    app_audience    = optional(string, "AzureADMyOrg")<br>    group_claims    = optional(list(string), ["All"])<br>    vault_id_prefix = optional(string, "vault-id")<br>    role_template   = optional(string, "Cloud Application Administrator")<br>  })</pre> | `{}` | no |
| <a name="input_azuread_oidc_claims"></a> [azuread\_oidc\_claims](#input\_azuread\_oidc\_claims) | AzureAD OIDC Optional claim configuration | <pre>object({<br>    access_token = optional(string, "groups")<br>    id_token     = optional(string, "groups")<br>    saml_token   = optional(string, "groups")<br>  })</pre> | `{}` | no |
| <a name="input_azuread_oidc_permission_scope"></a> [azuread\_oidc\_permission\_scope](#input\_azuread\_oidc\_permission\_scope) | AzureAD OIDC Application permission scoping and config. | <pre>object({<br>    admin_description  = optional(string, "Allow the application to access gated resources on behalf of the signed-in user.")<br>    admin_display_name = optional(string, "Vault Guardian")<br>    enabled            = optional(bool, true)<br>    template_user_id   = optional(string, "0c9a07ff-70d5-46e3-a995-d072f0696d20")<br>    type               = optional(string, "Admin")<br>    value              = optional(string, "admin")<br>  })</pre> | `{}` | no |
| <a name="input_azuread_oidc_resource_roles"></a> [azuread\_oidc\_resource\_roles](#input\_azuread\_oidc\_resource\_roles) | List of objects containing requested resource RBAC roles | <pre>list(object({<br>    id   = optional(string)<br>    type = optional(string)<br>  }))</pre> | <pre>[<br>  {<br>    "id": "GroupMember.Read.All",<br>    "type": "Role"<br>  },<br>  {<br>    "id": "Group.Read.All",<br>    "type": "Role"<br>  },<br>  {<br>    "id": "User.Read.All",<br>    "type": "Role"<br>  }<br>]</pre> | no |
| <a name="input_azuread_vault_role"></a> [azuread\_vault\_role](#input\_azuread\_vault\_role) | AzureAD RBAC role configuration | <pre>object({<br>    actions     = optional(list(string), ["*"])<br>    not_actions = optional(list(string), [])<br>  })</pre> | `{}` | no |
| <a name="input_azurerm_sub_id"></a> [azurerm\_sub\_id](#input\_azurerm\_sub\_id) | SYSTEM GENERATED: the current Azurerm subscription ID | `string` | `null` | no |
| <a name="input_current_client_object_id"></a> [current\_client\_object\_id](#input\_current\_client\_object\_id) | SYSTEM GENERATED: the current AzureAD client object ID | `string` | `null` | no |
| <a name="input_current_tenant_id"></a> [current\_tenant\_id](#input\_current\_tenant\_id) | SYSTEM GENERATED: the current AzureAD tenant ID | `string` | `null` | no |
| <a name="input_directory_role_templates"></a> [directory\_role\_templates](#input\_directory\_role\_templates) | SYSTEM GENERATED: map containing AzureAD directory role templates | `any` | `null` | no |
| <a name="input_msgraph_resource_id"></a> [msgraph\_resource\_id](#input\_msgraph\_resource\_id) | SYSTEM GENERATED: the resource object ID of the MSGraph API | `string` | `null` | no |
| <a name="input_msgraph_role_ids"></a> [msgraph\_role\_ids](#input\_msgraph\_role\_ids) | SYSTEM GENERATED: map with assignable MSGraph roles | `any` | `null` | no |
| <a name="input_oidc_redirect_uris"></a> [oidc\_redirect\_uris](#input\_oidc\_redirect\_uris) | List with URIs the OIDC application will redirect to | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_name"></a> [application\_name](#output\_application\_name) | Display name of Azure AD application. |
| <a name="output_application_uri"></a> [application\_uri](#output\_application\_uri) | Configured Application ID URIs of Azure AD application. |
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | Client ID of Azure AD application. |
| <a name="output_client_secret"></a> [client\_secret](#output\_client\_secret) | Client secret of Azure AD application. |
| <a name="output_client_secret_id"></a> [client\_secret\_id](#output\_client\_secret\_id) | Client secret ID of Azure AD application. |
| <a name="output_object_id"></a> [object\_id](#output\_object\_id) | Object ID of Azure AD application. |
| <a name="output_roles"></a> [roles](#output\_roles) | n/a |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | Tenant ID of Azure subscription. |
<!-- END_TF_DOCS -->