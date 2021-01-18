terraform {
  backend "gcs" {
    bucket = "ckspg-tf-state"
    prefix = "terraform/state"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.52.0"
    }
  }
}

provider "google" {
  project = "aziz-301518"
  region  = "europe-west4"
}
