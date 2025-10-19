resource "google_compute_network" "gke_main_vpc" {
  name = "gke-main-vpc"
  project = var.project
  auto_create_subnetworks  = false
}

resource "google_compute_subnetwork" "gke_app_usc1" {
  name = "gke-app-usc1"
  project = var.project
  region        = "us-central1"

  ip_cidr_range = "10.24.96.0/23"
  network = google_compute_network.gke_main_vpc.id

  secondary_ip_range {
    range_name    = "pod-ranges"
    ip_cidr_range = "10.158.0.0/16"
  }
  
  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = "10.159.0.0/16"
  }
}

resource "google_compute_subnetwork" "gke_app_use1" {
  name = "gke-app-use1"
  project = var.project
  region        = "us-east1"

  ip_cidr_range = "10.24.100.0/23"
  network = google_compute_network.gke_main_vpc.id

  secondary_ip_range {
    range_name    = "pod-ranges"
    ip_cidr_range = "10.178.0.0/16"
  }

  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = "10.179.0.0/16"
  }

}
