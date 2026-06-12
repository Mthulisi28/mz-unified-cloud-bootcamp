# Prod Environment Infrastructure Orchestrator - Full 3-Tier Core
# Consumes validated governance modules under strict production-tier parameters

module "iam_governance" {
  source      = "../../modules/iam"
  environment = "prod"
}

module "networking_governance" {
  source      = "../../modules/networking"
  environment = "prod"
}

module "logging_governance" {
  source      = "../../modules/logging"
  environment = "prod"
}

output "prod_operator_role" {
  value       = module.iam_governance.operator_role_id
  description = "Propagated operator role ID for prod environment execution"
}

output "prod_vpc_id" {
  value       = module.networking_governance.vpc_network_id
  description = "Propagated VPC network ID for prod environment workloads"
}

output "prod_log_sink_identity" {
  value       = module.logging_governance.log_sink_writer_identity
  description = "Propagated security identity for central prod audit routing"
}
