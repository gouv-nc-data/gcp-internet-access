resource "google_project_service" "activate_api" {
  for_each = toset(["compute.googleapis.com"])
  project  = var.project_id
  service  = each.key
}

resource "google_compute_network" "default" {
  project                 = var.project_id
  name                    = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "default" {
  project       = var.project_id
  name          = var.subnetwork_name
  region        = var.region
  network       = google_compute_network.default.id
  ip_cidr_range = var.ip_range

  private_ip_google_access = true
}

resource "google_compute_firewall" "allow-internal" {
  project = var.project_id
  name    = "allow-internal-traffic"
  network = google_compute_network.default.id

  allow {
    protocol = "all"
  }

  source_ranges = [var.ip_range]
}

resource "google_compute_firewall" "allow-outbound-specific-ip" {
  project   = var.project_id
  name      = "allow-outbound-specific-ip"
  network   = google_compute_network.default.id
  direction = "EGRESS"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  destination_ranges = [var.egress_ip_range]
}

resource "google_compute_router" "default" {
  project = var.project_id
  name    = var.router_name
  network = google_compute_network.default.id
}

resource "google_compute_router_nat" "default" {
  project = var.project_id
  name    = var.nat_name
  router  = google_compute_router.default.name

  nat_ip_allocate_option = "AUTO_ONLY"

  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
