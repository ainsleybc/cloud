resource "google_dns_managed_zone" "co_uk" {
  name     = "${var.website_name}-co-uk"
  dns_name = "${var.website_name}.co.uk."
}

resource "google_dns_record_set" "admin_co_uk_a" {
  managed_zone = "${google_dns_managed_zone.co_uk.name}"
  name         = "admin.${google_dns_managed_zone.co_uk.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${google_compute_instance.docker_vm.network_interface.0.access_config.0.nat_ip}"]
}

resource "google_dns_managed_zone" "com" {
  name     = "${var.website_name}-com"
  dns_name = "${var.website_name}.com."
}

resource "google_dns_record_set" "admin_com_a" {
  managed_zone = "${google_dns_managed_zone.com.name}"
  name         = "admin.${google_dns_managed_zone.com.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${google_compute_instance.docker_vm.network_interface.0.access_config.0.nat_ip}"]
}

resource "google_dns_record_set" "admin_com_caa" {
  managed_zone = "${google_dns_managed_zone.com.name}"
  name         = "admin.${google_dns_managed_zone.com.dns_name}"
  type         = "CAA"
  ttl          = 300
  rrdatas      = ["0 issue \"letsencrypt.org\"", "0 issuewild \";\""]
}
