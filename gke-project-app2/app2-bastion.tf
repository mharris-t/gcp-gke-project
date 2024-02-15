resource "google_compute_instance" "app2_vms" {
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
    # network = "default"
    subnetwork = each.value.subnetwork

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    VM = "${each.key}"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = data.terraform_remote_state.governance.outputs.app2_bast_svc_acc.email
    scopes = ["cloud-platform"]
  }
}

locals {
    VMs= {
    app2-bastion = {
        machine_type = "e2-micro"
        zone         = "europe-north1-a"
        tags         = ["app2", "bastion"]
        image        = "ubuntu-os-cloud/ubuntu-2204-lts"
        subnetwork      = "${data.terraform_remote_state.networking.outputs.app2_bast_subnet_self_links}"
    }

  }
}