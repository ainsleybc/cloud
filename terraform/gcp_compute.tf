resource "google_compute_instance" "docker_vm" {
  name         = "tf-docker-vm"
  machine_type = "f1-micro"
  tags         = ["docker"]

  boot_disk {
    initialize_params {
      image = "gce-uefi-images/ubuntu-1804-lts"
    }
  }

  network_interface {
    network = "default"

    access_config {
      nat_ip = "${google_compute_address.static.address}"
    }
  }

  metadata {
    ssh-keys = "root:${file("${var.ssh_key_path}")}"
  }

  service_account {
    scopes = ["compute-ro"]
  }
}
