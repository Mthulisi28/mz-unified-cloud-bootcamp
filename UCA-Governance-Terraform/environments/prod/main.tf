module "network_prod" {
  source = "../../modules/network"

  project_id   = "quickreserve-global-5223"
  network_name = "uca-quickreserve-prod-uscentral1-vpc-01"
  region       = "us-central1"
  web_cidr     = "10.20.1.0/24"
  app_cidr     = "10.20.2.0/24"
  db_cidr      = "10.20.3.0/24"
}

module "compute_prod" {
  source = "../../modules/compute"

  project_id   = "quickreserve-global-5223"
  environment  = "prod"
  region       = "us-central1"
  zone         = "us-central1-a"
  machine_type = "e2-micro" # Scaled for baseline execution stability
  
  # Bind directly to the production app subnet resource ID
  subnet_id    = "projects/quickreserve-global-5223/regions/us-central1/subnetworks/uca-quickreserve-prod-uscentral1-vpc-01-app-tier"
  network_tags = ["uca-app-engine"]

  depends_on = [module.network_prod]
}

module "logging_prod" {
  source      = "../../modules/logging"
  project_id  = var.project_id
  environment = "prod"
}

module "database_prod" {
  source      = "../../modules/database"
  project_id  = var.project_id
  environment = "prod"
  vpc_id      = module.network_prod.vpc_id
}

module "load_balancer_prod" {
  source      = "../../modules/load_balancer"
  project_id  = var.project_id
  environment = "prod"
}

output "prod_load_balancer_ip" {
  value       = module.load_balancer_prod.load_balancer_ip
  description = "The public IP address of the Production Global Ingress HTTP Load Balancer."
}

module "iam_governance_prod" {
  source      = "../../modules/iam"
  project_id  = "quickreserve-global-5223"
  environment = "prod"
}

output "prod_automation_runner_email" {
  value       = module.iam_governance_prod.runner_sa_email
  description = "The service account managed by the UCA production identity plane."
}

module "logging_governance_prod" {
  source      = "../../modules/logging"
  project_id  = "quickreserve-global-5223"
  environment = "prod"
}
