resource "google_compute_address" "k8s_ckspg_master" {
  name = "k8s-static-ip-master"
}

resource "google_compute_address" "k8s_ckspg_worker" {
  name = "k8s-static-ip-worker"
}

resource "google_compute_address" "k8s_ckspg" {
  name = "k8s-static-ip"
}

resource "google_compute_firewall" "k8s_int_ckspg" {
  name    = "k8s-int-ckspg"
  network = google_compute_network.ckspg.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  source_ranges = ["10.240.0.0/24", "10.200.0.0/16"]
}


resource "google_compute_firewall" "k8s_ext_ckspg" {
  name    = "k8s-ext-ckspg"
  network = google_compute_network.ckspg.name

  allow {
    protocol = "tcp"
    ports    = ["6443", "22"]
  }

  allow {
    protocol = "icmp"
  }


  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_subnetwork" "k8s_ckspg" {
  name          = "k8s"
  ip_cidr_range = var.subnet_range
  network       = google_compute_network.ckspg.id
}

resource "google_compute_network" "ckspg" {
  name                    = "ckspg"
  auto_create_subnetworks = false
}