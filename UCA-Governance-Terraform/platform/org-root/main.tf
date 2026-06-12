# Central Platform Orchestration - Organization Root Baseline
# Manages top-level Landing Zone variables and cross-account validation states

variable "organization_id" {
  type        = string
  description = "The target root enterprise organization identity"
  default     = "uca-global-org-2026"
}

variable "billing_account_id" {
  type        = string
  description = "Central billing identity for automated FinOps reconciliation"
  default     = "billing-uca-enterprise"
}

locals {
  governance_framework = "Unified Control Architecture"
  last_audit_epoch     = "1773414000" # June 2026 Deterministic Target
}

output "uca_org_status" {
  value       = "INITIALIZED"
  description = "Platform baseline readiness status flag"
}
