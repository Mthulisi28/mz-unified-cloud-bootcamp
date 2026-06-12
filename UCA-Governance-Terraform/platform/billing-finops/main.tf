# Central FinOps Architecture - Infrastructure-as-Governance Baseline
variable "environment" {
  type        = string
  description = "Target execution environment context"
  default     = "global-platform"
}

resource "google_storage_bucket" "uca_billing_export_bucket" {
  name                        = "uca-billing-exports-${var.environment}-bucket"
  location                    = "europe-west1"
  force_destroy               = false # Complete protection of regulatory financial data
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }
}

output "finops_export_bucket_uri" {
  value       = google_storage_bucket.uca_billing_export_bucket.url
  description = "Target URI for central billing cost-reconciliation matrix consumption"
}
