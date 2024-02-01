module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  for_each                   = local.envs 
  project_id                 = data.terraform_remote_state.projects.outputs.module.vpc["app1"].project_id
  name                       = "gke-app1-${each.key}"
  region                     = data.terraform_remote_state.projects.outputs.module.project-factory["app1"].region
  regional                   = each.value
  zones                      = ["us-central1-a", "us-central1-b", "us-central1-f"]
  network                    = "${data.terraform_remote_state.projects.outputs.module.vpc["app1"].network}"
  subnetwork                 = "us-central1-01"
  ip_range_pods              = "us-central1-01-gke-01-pods"
  ip_range_services          = "us-central1-01-gke-01-services"
  http_load_balancing        = false
  network_policy             = false
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = false

  node_pools = [
    {
      name                      = "default-node-pool"
      machine_type              = "e2-medium"
      node_locations            = "us-central1-b,us-central1-c"
      min_count                 = 1
      max_count                 = 100
      local_ssd_count           = 0
      spot                      = false
      disk_size_gb              = 100
      disk_type                 = "pd-standard"
      image_type                = "COS_CONTAINERD"
      enable_gcfs               = false
      enable_gvnic              = false
      logging_variant           = "DEFAULT"
      auto_repair               = true
      auto_upgrade              = false
      service_account           = "project-service-account@<PROJECT ID>.iam.gserviceaccount.com"
      preemptible               = false
      initial_node_count        = 80
    },
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    default-node-pool = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }
}

locals {
  envs = {
    dev = {
      project_id                 = data.terraform_remote_state.projects.outputs.app1_project_id
      region                     = provider.google.region
      regional                   = false
      zones                      = ["europe-north1-a", "europe-north1-b"]
      network                    = "${data.terraform_remote_state.projects.outputs.app1_gke_network}"
      subnetwork                 = "${data.terraform_remote_state.projects.outputs.app1_gke_subnets[0]}" #refer to node subnet
      ip_range_pods              = "${data.terraform_remote_state.projects.outputs.app1_gke_subnets[0][0]}"
      ip_range_services          = "${data.terraform_remote_state.projects.outputs.app1_gke_subnets[0][1]}"
      http_load_balancing        = false
      network_policy             = false
      horizontal_pod_autoscaling = true
      filestore_csi_driver       = false

        
    }

    prod = {

    }
  }
}