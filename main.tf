resource "random_string" "unique_id" {
  length    = 5
  min_lower = 5
  special   = false
}

resource "google_service_account" "cloudbase_service_account" {
  account_id   = "cloudbase-sa-org-${random_string.unique_id.result}"
  display_name = "Cloudbase Service Account"
  project      = var.project_id
}

resource "google_organization_iam_custom_role" "cloudbase_project_custom_role" {
  org_id  = var.organization_id
  role_id = "cloudbaseProjectPolicy${random_string.unique_id.result}"
  title   = "Cloudbase Project Policy ${random_string.unique_id.result}"
  permissions = var.enable_cnapp ? concat(
    var.cloudbase_project_role_permissions_cspm, var.cloudbase_project_role_permissions_cwpp
  ) : var.cloudbase_project_role_permissions_cspm
}

resource "google_organization_iam_custom_role" "cloudbase_org_custom_role" {
  org_id      = var.organization_id
  role_id     = "cloudbaseOrganizationPolicy${random_string.unique_id.result}"
  title       = "Cloudbase Organization Policy ${random_string.unique_id.result}"
  permissions = var.cloudbase_org_role_permissions
}

resource "google_organization_iam_member" "bind_security_reviewer_role" {
  org_id = var.organization_id
  role   = "roles/iam.securityReviewer"
  member = "serviceAccount:${google_service_account.cloudbase_service_account.email}"
}

resource "google_organization_iam_member" "bind_cloudbase_custom_role_prj" {
  org_id = var.organization_id
  role   = "organizations/${var.organization_id}/roles/${google_organization_iam_custom_role.cloudbase_project_custom_role.role_id}"
  member = "serviceAccount:${google_service_account.cloudbase_service_account.email}"
}

resource "google_organization_iam_member" "bind_cloudbase_custom_role_org" {
  org_id = var.organization_id
  role   = "organizations/${var.organization_id}/roles/${google_organization_iam_custom_role.cloudbase_org_custom_role.role_id}"
  member = "serviceAccount:${google_service_account.cloudbase_service_account.email}"
}

resource "google_project_service" "enable_apis" {
  for_each           = toset([
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
  ])
  project            = var.project_id
  service            = each.key
  disable_on_destroy = false
}