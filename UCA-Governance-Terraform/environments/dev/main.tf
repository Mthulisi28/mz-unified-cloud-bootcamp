module "network_dev" {
  source = "../../modules/network"

  project_id   = "quickreserve-global-5223"
  network_name = "uca-quickreserve-dev-uscentral1-vpc-01"
  region       = "us-central1"
  web_cidr     = "10.10.1.0/24"
  app_cidr     = "10.10.2.0/24"
  db_cidr      = "10.10.3.0/24"
}

module "compute_dev" {
  source = "../../modules/compute"

  project_id   = "quickreserve-global-5223"
  environment  = "dev"
  region       = "us-central1"
  zone         = "us-central1-a"
  machine_type = "e2-micro"
  
  subnet_id    = "projects/quickreserve-global-5223/regions/us-central1/subnetworks/uca-quickreserve-dev-uscentral1-vpc-01-app-tier"
  network_tags = ["uca-app-engine"]

  depends_on = [module.network_dev]
}

module "database_dev" {
  source      = "../../modules/database"
  project_id  = var.project_id
  environment = "dev"
  vpc_id      = module.network_dev.vpc_id
}

module "load_balancer_dev" {
  source      = "../../modules/load_balancer"
  project_id  = var.project_id
  environment = "dev"
}

output "dev_load_balancer_ip" {
  value       = module.load_balancer_dev.load_balancer_ip
  description = "The public IP address of the Global Ingress HTTP Load Balancer."
}

module "iam_governance_dev" {
  source      = "../../modules/iam"
  project_id  = "quickreserve-global-5223"
  environment = "dev"
}

output "dev_automation_runner_email" {
  value       = module.iam_governance_dev.runner_sa_email
  description = "The service account managed by the UCA identity plane."
}

module "logging_governance_dev" {
  source      = "../../modules/logging"
  project_id  = "quickreserve-global-5223"
  environment = "dev"
}