variable "project_id" { type = string }

resource "google_project_iam_binding" "enforce_owner" {
  project = var.project_id
  role    = "roles/owner"
  members = ["user:mthulisiz28@gmail.com"] # Lock ownership to your verified account
}
