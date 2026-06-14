variable "billing_account" {
  type        = string
  description = "The billing account ID"
}

resource "google_project" "security" {
  name            = "UCA-Security-Vault"
  project_id      = "uca-security-vault-001"
  billing_account = var.billing_account
}

resource "google_project" "infrastructure" {
  name            = "UCA-Infrastructure"
  project_id      = "uca-infra-001"
  billing_account = var.billing_account
}

resource "google_project" "prod" {
  name            = "UCA-Production"
  project_id      = "uca-prod-001"
  billing_account = var.billing_account
}

resource "google_project" "dev" {
  name            = "UCA-Development"
  project_id      = "uca-dev-001"
  billing_account = var.billing_account
}
