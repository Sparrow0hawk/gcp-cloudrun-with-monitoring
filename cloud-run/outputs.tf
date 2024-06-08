output "cloud-run-url" {
  value = google_cloud_run_v2_service.default.uri
}
