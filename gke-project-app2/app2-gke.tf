#! K8s Module
module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  for_each                   = local.envs 
  project_id                 = each.value.project_id
  name                       = "gke-app2-${each.key}"
  region                     = each.value.region
  regional                   = each.value.regional
  zones                      = each.value.zones
  network                    = each.value.network
  subnetwork                 = each.value.subnetwork
  ip_range_pods              = each.value.ip_range_pods
  ip_range_services          = each.value.ip_range_services
  http_load_balancing        = each.value.http_load_balancing
  network_policy             = each.value.network_policy
  horizontal_pod_autoscaling = each.value.horizontal_pod_autoscaling
  filestore_csi_driver       = each.value.filestore_csi_driver
  node_pools                 = each.value.node_pools

  node_pools_oauth_scopes    = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  node_pools_labels          = each.value.node_pools_labels
  node_pools_metadata        = each.value.node_pools_metadata
  node_pools_taints          = each.value.node_pools_taints
  node_pools_tags            = each.value.node_pools_tags
}

#! Kubernetes environment definition: dev and prod
locals {
  envs = {
    dev = {
      project_id                 = data.terraform_remote_state.projects.outputs.app2_project_id
      region                     = provider.google.region
      regional                   = false
      zones                      = ["europe-north1-a"]
      network                    = "${data.terraform_remote_state.projects.outputs.app2_gke_network}"
      subnetwork                 = "${data.terraform_remote_state.projects.outputs.app2_gke_subnets[1]}" #refer to node subnet
      ip_range_pods              = "${data.terraform_remote_state.projects.outputs.app2_gke_subnets[1][0]}"
      ip_range_services          = "${data.terraform_remote_state.projects.outputs.app2_gke_subnets[1][1]}"
      http_load_balancing        = false
      network_policy             = false
      horizontal_pod_autoscaling = true
      filestore_csi_driver       = false
      node_pools                 = [
        {
          name                      = "dev-node-pool"
          machine_type              = "e2-medium"
          node_locations            = " "
          min_count                 = 1
          max_count                 = 4
          local_ssd_count           = 0
          spot                      = false
          disk_size_gb              = 500
          disk_type                 = "pd-standard"
          image_type                = "COS_CONTAINERD"
          enable_gcfs               = false
          enable_gvnic              = false
          logging_variant           = "DEFAULT"
          auto_repair               = true
          auto_upgrade              = false
          service_account           = "${data.terraform_remote_state.governance.outputs.gov_svc_acc}"
          preemptible               = false
          initial_node_count        = 1
        },
      ]
          node_pools_labels         = {
              all = {}

              dev-node-pool = {
                dev-node-pool = true
              }
            }

          node_pools_metadata = {
              all = {}

              dev-node-pool = {
                node-pool-metadata-custom-value = "app2-dev-node-pool"
              }
            }

          node_pools_taints = {
              all = []

              dev-node-pool = []
            }

          node_pools_tags = {
              all = []

              dev-node-pool = [
                "dev-node-pool",
              ]
            }
        
    }

prod = {
      project_id                 = data.terraform_remote_state.projects.outputs.app2_project_id
      region                     = provider.google.region
      regional                   = true
      zones                      = ["europe-north1-a", "europe-north1-b"]
      network                    = "${data.terraform_remote_state.projects.outputs.app2_gke_network}"
      subnetwork                 = "${data.terraform_remote_state.projects.outputs.app2_gke_subnets[2]}" #refer to node subnet
      ip_range_pods              = "${data.terraform_remote_state.projects.outputs.app2_gke_subnets[2][0]}"
      ip_range_services          = "${data.terraform_remote_state.projects.outputs.app2_gke_subnets[2][1]}"
      http_load_balancing        = false
      network_policy             = false
      horizontal_pod_autoscaling = true
      filestore_csi_driver       = false
      node_pools                 = [
        {
          name                      = "prod-node-pool"
          machine_type              = "e2-standard-32"
          node_locations            = " "
          min_count                 = 1
          max_count                 = 12
          local_ssd_count           = 0
          spot                      = false
          disk_size_gb              = 500
          disk_type                 = "pd-standard"
          image_type                = "COS_CONTAINERD"
          enable_gcfs               = false
          enable_gvnic              = false
          logging_variant           = "DEFAULT"
          auto_repair               = true
          auto_upgrade              = false
          service_account           = "${data.terraform_remote_state.governance.outputs.gov_svc_acc}"
          preemptible               = false
          initial_node_count        = 5
        },
      ]
          node_pools_labels         = {
              all = {}

              prod-node-pool = {
                prod-node-pool = true
              }
            }

          node_pools_metadata = {
              all = {}

              prod-node-pool = {
                node-pool-metadata-custom-value = "app2-prod-node-pool"
              }
            }

          node_pools_taints = {
              all = []

              prod-node-pool = []
            }

          node_pools_tags = {
              all = []

              prod-node-pool = [
                "prod-node-pool",
              ]
            }
        
    }
  }
}