provider "google" {
  project     = "${data.terraform_remote_state.governance.outputs.app1_project_id}"
  region      = "europe-north1"
}

terraform {
  backend "gcs" {
    bucket  = "tf-state-gov"
    prefix  = "terraform/app1/state"
  }
}

data "terraform_remote_state" "networking" {
  backend = "gcs"
  config = {
    bucket  = "tf-state-gov"
    prefix  = "terraform/networking/state"
  }
}

data "terraform_remote_state" "governance" {
  backend = "gcs"
  config = {
    bucket  = "tf-state-gov"
    prefix  = "terraform/gov/state"
  }
}

#Utilize GOOGLE_APPLICATION_CREDENTIALS env variable to authenticate local machine or pipeline host
