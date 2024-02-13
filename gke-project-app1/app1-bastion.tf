resource "google_compute_instance" "app1_vms" {
  for_each     = local.VMs
  name         = "${each.key}"
  machine_type = "${each.value.machine_type}"
  zone         = "${each.value.zone}"
  tags         = each.value.zone

  boot_disk {
    initialize_params {
      image = each.value.label
      labels = {
        my_label = "${each.key}"
      }
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}

locals {
    VMs= {
    app1-bastion = {
        machine_type = "e2-micro"
        zone         = "europe-north1-a"
        tags         = ["app1", "bastion"]
        image        = "ubuntu-os-cloud/ubuntu-2204-lts"
        network      = "${data.terraform_remote_state.projects.outputs.app1_gke_subnets[0]}"
    }

  }
}