provider "google" {
  project     = "my-governance-project"
  region      = "europe-north1"
}

terraform {
  backend "gcs" {
    bucket  = "tf-state-gov"
    prefix  = "terraform/networking/state"
  }
}

data "terraform_remote_state" "projects" {
  backend = "gcs"
  config = {
    bucket  = "tf-state-gov"
    prefix  = "terraform/gov/state"
  }
}

#Utilize GOOGLE_APPLICATION_CREDENTIALS env variable to authenticate local machine or pipeline host
