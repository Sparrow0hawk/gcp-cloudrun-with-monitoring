resource "google_project_service" "monitoring" {
  project = var.project
  service = "monitoring.googleapis.com"
}

resource "google_monitoring_uptime_check_config" "cloud_run" {
  display_name = "cloud run uptime check"
  project      = var.project
  timeout      = "60s"
  period       = "60s"

  http_check {
    port           = "80"
    request_method = "GET"
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = var.project
      host       = trimprefix(var.cloud_run_url, "https://")
    }
  }

  checker_type = "STATIC_IP_CHECKERS"

  depends_on = [google_project_service.monitoring]
}

resource "google_monitoring_alert_policy" "alert_policy" {
  display_name = "Cloud run uptime alert"
  project      = var.project
  combiner     = "OR"
  conditions {
    display_name = "uptime check"
    condition_threshold {
      filter   = format("metric.type=\"monitoring.googleapis.com/uptime_check/check_passed\" AND metric.label.check_id=\"%s\" AND resource.type=\"uptime_url\"", google_monitoring_uptime_check_config.cloud_run.uptime_check_id)
      duration = "120s"
      comparison = "COMPARISON_LT"
      threshold_value = "1"
      trigger {
        count = 1
      }
    }
  }
  severity = "ERROR"
  notification_channels = [google_monitoring_notification_channel.email.id]
}

resource "google_monitoring_notification_channel" "email" {
  display_name = "Test Notification Channel"
  project      = var.project
  type         = "email"
  labels = {
    email_address = "canines_panacea_0u@icloud.com"
  }
  force_delete = false
}
