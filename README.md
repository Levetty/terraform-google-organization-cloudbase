# terraform-google-organization-cloudbase

A Terraform module to connect a Google Cloud Organization to Cloudbase.

## Usage
```
module "cloudbase" {
  source  = "Levetty/cloudbase/google-organization"
  version = "0.0.1"

  project_id      = "xxx" # required
  organization_id = "xxx" # required

  # optional: If you are on a CSPM plan rather than a CNAPP plan, please set the following to false.
  enable_cnapp = true

  # optional: if you want to custom role permissions, you can specify by these variables
  # cloudbase_org_role_permissions          = []
  # cloudbase_project_role_permissions_cwpp = []
  # cloudbase_project_role_permissions_cspm = []
}
```