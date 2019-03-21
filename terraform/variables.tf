variable "region" {}

variable "region_zone" {}

variable "project_name" {
  description = "The ID of the Google Cloud project"
}

variable "credentials_file_path" {
  description = "Path to the JSON file used to describe account credentials"
}

variable "ssh_key_path" {
  description = "Path to public key for server access"
}

variable "website_name" {
  description = "Website name to use for DNS records"
}
