terraform {
  backend "gcs" {
    bucket  = "uca-terraform-state-uca-infra-001"
    prefix  = "terraform/state/mgmt"
  }
}
