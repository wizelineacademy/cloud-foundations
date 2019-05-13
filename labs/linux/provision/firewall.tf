resource "google_compute_firewall" "allow-inbound" {
  name    = "allow-inbound"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["web-server"]
}

resource "google_compute_firewall" "allow-time" {
  name    = "allow-time"
  network = "default"

  allow {
    protocol = "udp"
    ports    = ["123"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["ntp"]
}
