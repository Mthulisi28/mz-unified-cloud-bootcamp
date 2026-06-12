terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
  # Placeholder for central state configuration managed by Automated Operator
  backend "gcs" {
    bucket = "uca-global-governance-tfstate"
    prefix = "platform/org-root"
  }
}

provider "google" {
  region  = "europe-west1" # Enterprise-grade default compliance region
}
