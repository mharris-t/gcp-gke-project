module "vpc" {
    source  = "terraform-google-modules/network/google"
    version = "~> 9.0"
    for_each = locals.networking_env
    project_id   = "${each.key}"
    network_name = "gke-vpc-${each.key}"
    routing_mode = "GLOBAL"

    subnets = [
        {
            subnet_name           = "node-subnet-${each.key}"
            subnet_ip             = "${each.value.node_subnet}"
            subnet_region         = "${each.value.region}"
            description           = "This is the primary node subnet for ${each.key}"
        }
    ]

    secondary_ranges = {
        subnet-01 = [
            {
                range_name    = "pod-subnet-${each.key}"
                ip_cidr_range = "${each.value.pod_subnet}"
            }
        ]
    }

    routes = []
}

locals {
  networking_env = {

  dev = {
    project_id  = data.terraform_remote_state.projects.outputs.module.project-factory["dev"].project_id
    region      = provider.google.region
    node_subnet = "10.10.0.0/28" #12 nodes
    pod_subnet  = "100.10.0.0/22" #440 pods
 }

  test = {
    project_id = data.terraform_remote_state.projects.outputs.module.project-factory["test"].project_id
    region      = provider.google.region
    node_subnet = "10.20.0.0/28" #12 nodes
    pod_subnet  = "100.20.0.0/22" #440 pods
  }

  prod = {
    project_id = data.terraform_remote_state.projects.outputs.module.project-factory["prod"].project_id
    region      = provider.google.region
    node_subnet = "10.30.0.0/26" #60 nodes
    pod_subnet  = "100.30.0.0/22" #440 pods
  }

  } 
}