resource "google_compute_instance" "app_server" {
  name         = "uca-${var.environment}-app-server-01"
  machine_type = var.machine_type
  zone         = var.zone
  project      = var.project_id
  tags         = var.network_tags

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 20
      type  = "pd-standard"
    }
  }

  network_interface {
    subnetwork = var.subnet_id
  }

  metadata = {
    block-project-ssh-keys = "true"
    enable-oslogin         = "TRUE"
  }

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
