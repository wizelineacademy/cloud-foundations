data "google_compute_image" "image_os" {
  name    = "centos-7-oldkernel"
  project = "wizeline-interviews"
}

resource "google_compute_instance" "default" {
  count        = "${var.instance_count}"
  name         = "lab-machine-${count.index}"
  machine_type = "f1-micro"
  zone         = "us-west1-b"


  tags = ["web-server", "ntp"]

  boot_disk {
    initialize_params {
      image = "${data.google_compute_image.image_os.self_link}"
      size  = "${var.disk_size}"
    }
  }
  metadata_startup_script = "sudo yum install docker ntp -y && systemctl start docker.service ntpd.service"
  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}

output "ip" {
 value = "${google_compute_instance.default.*.network_interface.0.access_config.0.nat_ip}"
}
