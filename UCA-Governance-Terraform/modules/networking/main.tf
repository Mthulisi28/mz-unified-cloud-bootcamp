variable "environment" {
  type        = string
  description = "Target deployment environment (dev, test, prod)"
}

resource "google_compute_network" "uca_vpc" {
  name                    = "uca-vpc-${var.environment}"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "uca_private_subnet" {
  name                     = "uca-subnet-${var.environment}-primary"
  ip_cidr_range            = var.environment == "prod" ? "10.0.1.0/24" : "10.1.1.0/24"
  region                   = "europe-west1"
  network                  = google_compute_network.uca_vpc.id
  private_ip_google_access = true
}

output "vpc_network_id" {
  value       = google_compute_network.uca_vpc.id
  description = "Network resource reference for down-stream environment binding"
}
