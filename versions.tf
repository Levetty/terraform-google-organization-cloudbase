terraform {
  required_providers {
    google      = "~> 6.18"
    google-beta = "~> 6.18"
    random      = "~> 3.6"
  }
}

provider "google-beta" {
  project = var.project_id
}
