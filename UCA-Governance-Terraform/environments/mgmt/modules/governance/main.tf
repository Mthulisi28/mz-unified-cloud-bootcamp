variable "project_id" {
  description = "The ID of the project to enforce UCA policies"
  type        = string
}

# 1. Restrict External IPs
resource "google_project_organization_policy" "restrict_external_ip" {
  project    = var.project_id
  constraint = "compute.restrictExternalIpAccess"
  boolean_policy {
    enforced = true
  }
}

# 2. Disable Service Account Key Creation
resource "google_project_organization_policy" "disable_sa_keys" {
  project    = var.project_id
  constraint = "iam.disableServiceAccountKeyCreation"
  boolean_policy {
    enforced = true
  }
}

# 3. Restrict Resource Locations (e.g., South Africa)
resource "google_project_organization_policy" "restrict_resource_locations" {
  project    = var.project_id
  constraint = "gcp.resourceLocations"
  list_policy {
    allow {
      values = ["in:southafrica-locations"]
    }
  }
}