variable "project_id" {
  type        = string
  description = "Target GCP Project ID for Centralized Logging"
}

variable "environment" {
  type        = string
  description = "Deployment environment scope (dev, prod)"
}

variable "location" {
  type        = string
  description = "The storage bucket location topology"
  default     = "us-central1"
}

# The Centralized Immutable Audit Log Storage Bucket
resource "google_storage_bucket" "audit_logs" {
  name                        = "uca-audit-logs-${var.environment}-${var.project_id}"
  location                    = upper(var.location)
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
  force_destroy               = var.environment == "dev" ? true : false

  lifecycle_rule {
    condition {
      age = 90
    }
    action {
      type = "Delete"
    }
  }
}

# Create a Project-Wide Logging Sink to route Audit Logs to the Bucket
resource "google_logging_project_sink" "audit_sink" {
  name        = "uca-audit-sink-${var.environment}"
  destination = "storage.googleapis.com/${google_storage_bucket.audit_logs.name}"
  filter      = "logName:\"logs/cloudaudit.googleapis.com\""

  unique_writer_identity = true
}

# Grant the Sink service identity write permissions onto the logging bucket
resource "google_storage_bucket_iam_member" "sink_writer" {
  bucket = google_storage_bucket.audit_logs.name
  role   = "roles/storage.objectCreator"
  member = google_logging_project_sink.audit_sink.writer_identity
}
