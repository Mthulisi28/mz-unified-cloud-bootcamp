terraform {
  backend "gcs" {
    bucket = "uca-bootstrap-state-org-root"
    prefix = "platform/org-root"
  }
}
