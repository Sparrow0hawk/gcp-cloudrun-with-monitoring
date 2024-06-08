resource "google_project_service" "run" {
  project = var.project
  service = "run.googleapis.com"
}

resource "google_cloud_run_v2_service" "default" {
  name     = "cloudrun-service"
  project  = var.project
  location = var.location
  ingress = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
    }
  }
  depends_on = [google_project_service.run]
}

resource "google_cloud_run_v2_service_iam_binding" "default" {
  name     = google_cloud_run_v2_service.default.name
  project  = var.project
  location = var.location

  role = "roles/run.invoker"
  members = [
    "allUsers"
  ]
}
