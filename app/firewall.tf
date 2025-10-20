#resource "google_compute_firewall" "deny_all_egress" {
#  name        = "gke-fw-deny-all-egress"
#  project   = var.project
#  network     = google_compute_network.gke_main_vpc.id
#  direction   = "EGRESS"
#  priority    = 65535 # Lowest priority to ensure it's a default deny
#  description = "Deny all egress traffic by default"
#
#  deny {
#    protocol = "all"
#  }
#
#  destination_ranges = ["0.0.0.0/0"]
#}
#
#resource "google_compute_firewall" "allow_egress_to_pga_https" {
#  name        = "gke-fw-allow-egress-to-pga-https"
#  project   = var.project
#  network     = google_compute_network.gke_main_vpc.id
#  direction   = "EGRESS"
#  priority    = 1000
#  description = "Allow egress from pods and nodes to Private Google Access HTTPS ranges"
#
#  destination_ranges = [
#    "199.36.153.8/30",
#  ]
#
#  allow {
#    protocol = "tcp"
#    ports    = ["443"]
#  }
#}
#
#resource "google_compute_firewall" "allow_egress_to_nodes_kubelet" {
#  name        = "gke-fw-allow-egress-to-nodes-kubelet"
#  project   = var.project
#  network     = google_compute_network.gke_main_vpc.id
#  direction   = "EGRESS"
#  priority    = 1000
#  description = "Allow egress from pods and nodes to node IPs (kubelet)"
#
#  target_tags        = [
#    local.tools_usc1,
#    local.tools_use1
#  ]
#
#  destination_ranges = [
#    google_compute_subnetwork.gke_app_usc1.ip_cidr_range,
#    google_compute_subnetwork.gke_app_use1.ip_cidr_range
#  ]
#
#  source_ranges = [
#    google_compute_subnetwork.gke_app_usc1.secondary_ip_range[0].ip_cidr_range,
#    google_compute_subnetwork.gke_app_usc1.ip_cidr_range,
#    google_compute_subnetwork.gke_app_use1.secondary_ip_range[0].ip_cidr_range,
#    google_compute_subnetwork.gke_app_use1.ip_cidr_range,
#  ]
#
#
#  allow {
#    protocol = "tcp"
#    ports    = ["10255", "10250"]
#  }
#}
#
#resource "google_compute_firewall" "allow_egress_to_pods_and_nodes_all" {
#  name        = "gke-fw-allow-egress-to-pods-and-nodes-all"
#  project   = var.project
#  network     = google_compute_network.gke_main_vpc.id
#  direction   = "EGRESS"
#  priority    = 1000
#  description = "Allow egress from pods to all pod and node IPs (pod-to-pod and pod-to-node intra-VPC)"
#
#  target_tags        = [
#    local.tools_usc1,
#    local.tools_use1
#  ]
#
#  destination_ranges = [
#    google_compute_subnetwork.gke_app_usc1.secondary_ip_range[0].ip_cidr_range,
#    google_compute_subnetwork.gke_app_usc1.ip_cidr_range,
#    google_compute_subnetwork.gke_app_use1.secondary_ip_range[0].ip_cidr_range,
#    google_compute_subnetwork.gke_app_use1.ip_cidr_range,
#  ]
#  source_ranges = [
#    google_compute_subnetwork.gke_app_usc1.secondary_ip_range[0].ip_cidr_range,
#    google_compute_subnetwork.gke_app_use1.secondary_ip_range[0].ip_cidr_range,
#  ]
#
#  allow {
#    protocol = "all"
#  }
#}
#
#resource "google_compute_firewall" "allow_egress_nodes_to_nodes_all" {
#  name        = "gke-fw-allow-egress-nodes-to-nodes-all"
#  project   = var.project
#  network     = google_compute_network.gke_main_vpc.id
#  direction   = "EGRESS"
#  priority    = 1000
#  description = "Allow egress from all node IPs to all node IPs (node-to-node intra-VPC)"
#
#  target_tags        = [
#    local.tools_usc1,
#    local.tools_use1
#  ]
#  
#  destination_ranges = [
#    google_compute_subnetwork.gke_app_usc1.ip_cidr_range,
#    google_compute_subnetwork.gke_app_use1.ip_cidr_range,
#  ]
#  source_ranges      = [
#    google_compute_subnetwork.gke_app_usc1.ip_cidr_range,
#    google_compute_subnetwork.gke_app_use1.ip_cidr_range,
#  ]
#
#  allow {
#    protocol = "all"
#  }
#}
