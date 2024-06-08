resource "google_project_service" "monitoring" {
  project = var.project
  service = "monitoring.googleapis.com"
}

resource "google_monitoring_uptime_check_config" "cloud_run" {
  display_name = "cloud run uptime check"
  project      = var.project
  timeout      = "60s"

  http_check {
    port           = "80"
    request_method = "GET"
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = var.project
      host       = trim(var.cloud_run_url, "https://")
    }
  }

  checker_type = "STATIC_IP_CHECKERS"

  depends_on = [google_project_service.monitoring]
}
