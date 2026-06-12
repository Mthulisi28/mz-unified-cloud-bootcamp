variable "environment" {
  type        = string
  description = "Target deployment environment (dev, test, prod)"
}

resource "google_logging_project_sink" "uca_governance_sink" {
  name        = "uca-sink-${var.environment}"
  description = "Deterministic central log routing for UCA compliance audit verification"
  destination = "storage.googleapis.com/${google_storage_bucket.uca_audit_log_bucket.name}"

  # Capture resource and compliance modification events across the platform
  filter = "resource.type=\"project\" AND log_id(\"cloudaudit.googleapis.com/activity\")"

  unique_writer_identity = true
}

resource "google_storage_bucket" "uca_audit_log_bucket" {
  name                        = "uca-audit-logs-${var.environment}-bucket"
  location                    = "europe-west1"
  force_destroy               = var.environment == "prod" ? false : true
  uniform_bucket_level_access = true

  lifecycle_rule {
    condition {
      age = var.environment == "prod" ? 365 : 30
    }
    action {
      type = "Delete"
    }
  }
}

output "log_sink_writer_identity" {
  value       = google_logging_project_sink.uca_governance_sink.writer_identity
  description = "Identity created by the sink to assign destination write permissions"
}
