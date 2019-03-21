resource "google_compute_disk" "docker_vm" {
  name = "tf-docker-vm-data"
  type = "pd-standard"
  size = 5
}

resource "google_compute_attached_disk" "docker_vm" {
  disk     = "${google_compute_disk.docker_vm.self_link}"
  instance = "${google_compute_instance.docker_vm.self_link}"
}
