provider "google" {
  project = "wizeline-interviews"
  region = "us-west1"
  credentials = "${file("wizeline-interviews.json")}"
}

terraform {
  backend "gcs" {
    bucket  = "wizeline-interviews"
    prefix  = "foundations/linux/lab/state"
    project = "wizeline-interviews"
  }
}


