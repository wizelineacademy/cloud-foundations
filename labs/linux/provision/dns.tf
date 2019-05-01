resource "google_dns_record_set" "web-app" {
  count =  "${var.instance_count}"
  name  = "web-${count.index}.${google_dns_managed_zone.cloud.dns_name}"
  type  = "A"
  ttl   = 300

  managed_zone = "${google_dns_managed_zone.cloud.name}"

  rrdatas = ["${element("${google_compute_instance.default.*.network_interface.0.access_config.0.nat_ip}", count.index)}"]
}

resource "google_dns_managed_zone" "cloud" {
  name     = "wizeline-dev"
  dns_name = "cloud.wizeline.dev."
}
