resource "google_compute_instance" "k8s_master" {
  name                      = "k8s-master"
  machine_type              = var.machine_type
  zone                      = var.zone
  allow_stopping_for_update = "true"
  can_ip_forward            = "true"
  tags                      = ["ckspg", "master", "k8s"]

  boot_disk {
    initialize_params {
      image = var.image
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.k8s_ckspg.name
    network_ip = "10.240.0.10"
    access_config {
      nat_ip = google_compute_address.k8s_ckspg_master.address
    }
  }

  metadata = {
    ssh-keys = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
  }

  service_account {
    scopes = ["compute-rw", "storage-ro", "service-management", "service-control", "logging-write", "monitoring"]
  }
}


resource "google_compute_instance" "k8s_worker" {
  name                      = "k8s-worker"
  machine_type              = var.machine_type
  zone                      = var.zone
  allow_stopping_for_update = "true"
  can_ip_forward            = "true"
  tags                      = ["ckspg", "worker", "k8s"]

  boot_disk {
    initialize_params {
      image = var.image
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.k8s_ckspg.name
    network_ip = "10.240.0.20"
    access_config {
      nat_ip = google_compute_address.k8s_ckspg_worker.address
    }
  }
  metadata = {
    pod-cidr = "10.200.0.0/24"
    ssh-keys = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
  }

  service_account {
    scopes = ["compute-rw", "storage-ro", "service-management", "service-control", "logging-write", "monitoring"]
  }
}