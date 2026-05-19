resource "google_compute_network" "vpc" {
  name                    = "mz-global-mesh-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "web-tier" {
  name          = "web-tier"
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc.id
} resource "google_compute_subnetwork" "app-tier" {
  name          = "app-tier"
  ip_cidr_range = "10.0.2.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc.id
} resource "google_compute_subnetwork" "data-tier" {
  name          = "data-tier"
  ip_cidr_range = "10.0.3.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc.id
}
