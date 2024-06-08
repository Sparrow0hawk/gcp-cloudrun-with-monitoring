locals {
  project  = "cloudrun-with-monitoring"
  location = "europe-west2"
}

module "cloud-run" {
  source   = "./cloud-run"
  project  = local.project
  location = local.location
}

module "uptime-check" {
  source        = "./uptime-check"
  project       = local.project
  cloud_run_url = module.cloud-run.cloud-run-url
}
