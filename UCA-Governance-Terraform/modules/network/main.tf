resource "google_compute_network" "vpc" {
  name                    = var.network_name
  project                 = var.project_id
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "web-tier" {
  name          = "${var.network_name}-web-tier"
  ip_cidr_range = var.web_cidr
  region        = var.region
  project       = var.project_id
  network       = google_compute_network.vpc.id
}

resource "google_compute_subnetwork" "app-tier" {
  name          = "${var.network_name}-app-tier"
  ip_cidr_range = var.app_cidr
  region        = var.region
  project       = var.project_id
  network       = google_compute_network.vpc.id
}

resource "google_compute_subnetwork" "db-tier" {
  name          = "${var.network_name}-db-tier"
  ip_cidr_range = var.db_cidr
  region        = var.region
  project       = var.project_id
  network       = google_compute_network.vpc.id
}

# RULE 1: Allow public ingress exclusively to instances tagged as web proxies
resource "google_compute_firewall" "allow_lb_to_web" {
  name    = "${var.network_name}-allow-lb-to-web"
  network = google_compute_network.vpc.name
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["uca-web-ingress"]
}

# RULE 2: Restrict application tier ingress to traffic originating from the web proxy layer
resource "google_compute_firewall" "allow_web_to_app" {
  name    = "${var.network_name}-allow-web-to-app"
  network = google_compute_network.vpc.name
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_tags = ["uca-web-ingress"]
  target_tags = ["uca-app-engine"]
}

# RULE 3: Lock down database storage tier to accept requests exclusively from application layer
resource "google_compute_firewall" "allow_app_to_db" {
  name    = "${var.network_name}-allow-app-to-db"
  network = google_compute_network.vpc.name
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["5432"]
  }

  source_tags = ["uca-app-engine"]
  target_tags = ["uca-db-storage"]
}

# Secure Ingress Perimeter: Allow administrative transit exclusively via Google IAP Tunneling
resource "google_compute_firewall" "allow_iap_to_app" {
  name    = "${var.network_name}-allow-iap-to-app"
  network = google_compute_network.vpc.name
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  # Strict Google IAP secure tunnel proxy netblock source range
  source_ranges = ["35.235.240.0/20"]
  target_tags   = ["uca-app-engine"]
}

# 1. Create a Regional Cloud Router to handle dynamic egress routing
resource "google_compute_router" "nat_router" {
  name    = "${var.network_name}-nat-router"
  region  = var.region
  network = google_compute_network.vpc.id
  project = var.project_id
}

# 2. Deploy a High-Availability Cloud NAT Gate attached to the Router
resource "google_compute_router_nat" "nat_gateway" {
  name                               = "${var.network_name}-nat-gateway"
  router                             = google_compute_router.nat_router.name
  region                             = var.region
  project                            = var.project_id
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
