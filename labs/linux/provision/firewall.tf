resource "google_compute_firewall" "allow-inbound" {
  name    = "allow-inbound"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["web"]
}
