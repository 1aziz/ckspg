variable "zone" {
  type    = string
  default = "europe-west4-b"
}

variable "image" {
  description = "Image family and (image) project used for provisioning instances"
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-2004-lts"
}

variable "machine_type" {
  description = "Type of VM used for both k8s master(s) and worker(s)"
  type        = string
  default     = "e2-medium"
}

variable "subnet_range" {
  type    = string
  default = "10.240.0.0/24"
}

variable "gce_ssh_user" {
  type    = string
  default = "ansible"
}

variable "gce_ssh_pub_key_file" {
  type    = string
  default = "ssh/ansible.pub"
}