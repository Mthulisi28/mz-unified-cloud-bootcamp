# Dev Environment Infrastructure Orchestrator
# Consumes validated modules under strict deterministic control

module "iam_governance" {
  source      = "../../modules/iam"
  environment = "dev"
}

module "networking_governance" {
  source      = "../../modules/networking"
  environment = "dev"
}

output "dev_operator_role" {
  value       = module.iam_governance.operator_role_id
  description = "Propagated operator role ID for dev environment execution"
}

output "dev_vpc_id" {
  value       = module.networking_governance.vpc_network_id
  description = "Propagated VPC network ID for dev environment workloads"
}
