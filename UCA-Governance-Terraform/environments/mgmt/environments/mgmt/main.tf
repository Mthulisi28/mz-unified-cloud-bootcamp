# Your existing org_hierarchy module
module "org_hierarchy" {
  source = "../../modules/org-hierarchy"
}

# Your new governance modules
module "governance_dev" {
  source     = "../../modules/governance"
  project_id = "uca-dev-001"
}

module "governance_prod" {
  source     = "../../modules/governance"
  project_id = "uca-prod-001"
}

module "governance_vault" {
  source     = "../../modules/governance"
  project_id = "uca-security-vault-001"
}