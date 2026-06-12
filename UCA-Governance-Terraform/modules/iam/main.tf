# Central IAM Architecture - Infrastructure-as-Governance Baseline
variable "environment" {
  type        = string
  description = "Target deployment environment (dev, test, prod)"
}

# High-Value Execution Role used by the Automated Operator
resource "google_project_iam_custom_role" "uca_automated_operator" {
  role_id     = "UCA_Automated_Operator_${var.environment}"
  title       = "UCA Automated Operator Role"
  description = "Deterministic rule-based execution role with zero manual access"
  permissions = [
    "compute.networks.create",
    "compute.networks.updatePolicy",
    "resourcemanager.projects.get",
    "iam.roles.create"
  ]
}

output "operator_role_id" {
  value       = google_project_iam_custom_role.uca_automated_operator.id
  description = "Exported role reference for downstream platform consumption"
}
