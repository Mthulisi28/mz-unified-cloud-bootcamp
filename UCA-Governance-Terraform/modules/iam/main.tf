variable "project_id" {
  type        = string
  description = "Target GCP Project ID for Governance Architecture"
}

variable "environment" {
  type        = string
  description = "Deployment environment scope (dev, prod, etc.)"
  default     = "dev"
}

# The Master Automation Runner (Zero static privileges)
resource "google_service_account" "terraform_runner" {
  account_id   = "uca-tf-runner-${var.environment}"
  display_name = "UCA Engine Automation Runner (${var.environment})"
  project      = var.project_id
}

# Granular Cloud Access Handlers (Assumed via Runtime Tokens)
resource "google_project_iam_member" "runner_networking" {
  project = var.project_id
  role    = "roles/compute.networkAdmin"
  member  = "serviceAccount:${google_service_account.terraform_runner.email}"
}

resource "google_project_iam_member" "runner_database" {
  project = var.project_id
  role    = "roles/cloudsql.admin"
  member  = "serviceAccount:${google_service_account.terraform_runner.email}"
}

output "runner_sa_email" {
  value       = google_service_account.terraform_runner.email
  description = "The identity string of the master automation account."
}
