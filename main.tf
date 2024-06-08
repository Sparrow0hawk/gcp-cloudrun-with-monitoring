locals {
  project  = "cloudrun-with-monitoring"
  location = "europe-west2"
}

module "cloud-run" {
  source   = "./cloud-run"
  project  = local.project
  location = local.location
}
