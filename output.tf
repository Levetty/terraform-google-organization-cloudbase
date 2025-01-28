output "service_account_email" {
  value = google_service_account.cloudbase_service_account.email
}

output "service_account_key_url" {
  value = "https://console.cloud.google.com/iam-admin/serviceaccounts/details/${google_service_account.cloudbase_service_account.unique_id}/keys?project=${var.project_id}"
}