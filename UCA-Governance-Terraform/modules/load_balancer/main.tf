variable "project_id" { type = string }
variable "environment" { type = string }

resource "google_compute_global_forwarding_rule" "http_forwarding" {
  name       = "uca-lb-forwarding-${var.environment}"
  project    = var.project_id
  target     = google_compute_target_http_proxy.http_proxy.id
  port_range = "80"
}

resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "uca-lb-proxy-${var.environment}"
  project = var.project_id
  url_map = google_compute_url_map.url_map.id
}

resource "google_compute_url_map" "url_map" {
  name            = "uca-lb-url-map-${var.environment}"
  project         = var.project_id
  default_service = google_compute_backend_service.backend_service.id
}

resource "google_compute_backend_service" "backend_service" {
  name                  = "uca-lb-backend-${var.environment}"
  project               = var.project_id
  protocol              = "HTTP"
  port_name             = "http"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  timeout_sec           = 30

  health_checks = [google_compute_health_check.http_health_check.id]
}

resource "google_compute_health_check" "http_health_check" {
  name               = "uca-lb-health-check-${var.environment}"
  project            = var.project_id
  timeout_sec        = 5
  check_interval_sec = 5

  http_health_check {
    port = 80
  }
}

output "load_balancer_ip" {
  value = google_compute_global_forwarding_rule.http_forwarding.ip_address
}
