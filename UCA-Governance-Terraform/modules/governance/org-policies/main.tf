variable "project_id" {
  type = string
}

resource "google_org_policy_policy" "restrict_resource_location" {
  name   = "projects/${var.project_id}/policies/gcp.resourceLocations"
  parent = "projects/${var.project_id}"

  spec {
    rules {
      values {
        allowed_values = ["locations/us-central1"]
      }
    }
  }
}
