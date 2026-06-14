# UCA Governance Guardrail: Disable External IP Access
resource "google_project_organization_policy" "restrict_external_ip" {
  project    = "uca-infra-001" # Target your Infrastructure project
  constraint = "compute.restrictExternalIpAccess"

  boolean_policy {
    enforced = true
  }
}

# UCA Governance Guardrail: Restrict Resource Locations
resource "google_project_organization_policy" "restrict_resource_locations" {
  project    = "uca-infra-001"
  constraint = "gcp.resourceLocations"

  list_policy {
    allow {
      values = ["in:southafrica-locations"] # Enforcing data residency
    }
  }
}