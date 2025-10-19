terraform {
  backend "gcs" {
    bucket  = "sherill-tf-state"
    prefix  = "prod"
  }
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "7.7.0"
    }
  }
}

variable "project" { default = "github-actions-475520" }

provider "google" {
    project = "var.project"
}

