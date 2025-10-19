provider "kubernetes" {
  host                   = google_container_cluster.tools_cluster_usc1.endpoint
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.tools_cluster_usc1.master_auth[0].cluster_ca_certificate)
}

data "google_client_config" "default" {}

locals {
  tools_usc1 = "gke-tools-cluster-usc1"
  tools_use1 = "gke-tools-cluster-use1"
}

resource "google_container_cluster" "tools_cluster_usc1" {
  name      = "gke-tools-cluster-usc1"
  project   = var.project
  location  = "us-central1"
  deletion_protection = false

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.gke_main_vpc.id
  subnetwork = google_compute_subnetwork.gke_app_usc1.id

  private_cluster_config {
    enable_private_nodes        = true
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = google_compute_subnetwork.gke_app_usc1.secondary_ip_range[0].range_name
    services_secondary_range_name = google_compute_subnetwork.gke_app_usc1.secondary_ip_range[1].range_name
  }

  node_config {
    tags = [local.tools_usc1]
  }

}

resource "google_container_node_pool" "tools_nodepool_usc1" {
  name     = "tools-nodepool-usc1"
  location  = "us-central1"
  project   = var.project
  cluster  = google_container_cluster.tools_cluster_usc1.name


  max_pods_per_node = 32

  autoscaling {
    min_node_count  = 0
    max_node_count = 3
  }

  node_config {
    machine_type = "e2-medium"
    image_type   = "UBUNTU_CONTAINERD"
    disk_size_gb    = 20
    preemptible   = false
    tags = [local.tools_usc1]

    service_account = "terraform@github-actions-475520.iam.gserviceaccount.com"
  }

  management {
    auto_repair  = true
  }

}