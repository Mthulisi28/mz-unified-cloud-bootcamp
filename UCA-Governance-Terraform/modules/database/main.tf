variable "project_id" { type = string }
variable "environment" { type = string }
variable "vpc_id" { type = string }

resource "google_compute_global_address" "private_ip_alloc" {
  name          = "uca-db-private-ip-${var.environment}"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.vpc_id
  project       = var.project_id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = var.vpc_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_alloc.name]
}

resource "google_sql_database_instance" "postgres" {
  name             = "uca-db-${var.environment}-${var.project_id}"
  database_version = "POSTGRES_15"
  region           = "us-central1"
  project          = var.project_id

  depends_on = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.vpc_id
    }
  }
}

output "db_instance_ip" {
  value = google_sql_database_instance.postgres.private_ip_address
}
