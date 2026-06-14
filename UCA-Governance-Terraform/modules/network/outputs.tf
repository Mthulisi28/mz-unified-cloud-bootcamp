output "vpc_id" {
  value       = google_compute_network.vpc.id
  description = "The definitive unique resource ID of the instantiated global VPC."
}

output "web_subnet_id" {
  value       = google_compute_subnetwork.web-tier.id
  description = "The specific subnet ID tracking the ingress web tier."
}

output "app_subnet_id" {
  value       = google_compute_subnetwork.app-tier.id
  description = "The specific subnet ID tracking the private application tier."
}

output "db_subnet_id" {
  value       = google_compute_subnetwork.db-tier.id
  description = "The specific subnet ID tracking the isolated database storage layer."
}
