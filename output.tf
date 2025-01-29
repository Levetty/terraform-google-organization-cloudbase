output "service_account_name" {
  value = google_service_account.cloudbase_service_account.name
}

output "service_account_key_url" {
  description = "URL to issue and download the service account key"
  value       = "https://console.cloud.google.com/iam-admin/serviceaccounts/details/${google_service_account.cloudbase_service_account.unique_id}/keys?project=${var.project_id}"
}