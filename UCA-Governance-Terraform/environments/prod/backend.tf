terraform {
  backend "gcs" {
    bucket = "uca-bootstrap-state-org-root"
    prefix = "terraform/state/environments/prod"  # Strict production partition
  }
}
