output "network_name" {
  value = google_compute_network.default.name
  description = "Nom du réseau créé."
}
