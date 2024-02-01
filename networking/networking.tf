#! Add VPC with primary and secondary subnets for GKE clusters
module "vpc" {
    source  = "terraform-google-modules/network/google"
    version = "~> 9.0"
    for_each = locals.networking_env
    project_id   = "${each.value.project_id}"
    network_name = "gke-vpc-${each.key}"
    routing_mode = "GLOBAL"

    subnets = [
        {
            subnet_name           = "node-subnet-dev"
            subnet_ip             = "${each.value.node_subnet_dev}"
            subnet_region         = "${each.value.region}"
            description           = "This is the primary dev node subnet for ${each.key}"
        },
        {
            subnet_name           = "node-subnet-prod"
            subnet_ip             = "${each.value.node_subnet_prod}"
            subnet_region         = "${each.value.region}"
            description           = "This is the primary prod node subnet for ${each.key}"
        }
    ]

    secondary_ranges = {
        node-subnet-dev = [
            {
                range_name    = "pod-subnet-dev"
                ip_cidr_range = "${each.value.pod_subnet_dev}"
            },
            {
                range_name    = "svc-subnet-dev"
                ip_cidr_range = "${each.value.pod_subnet_dev}"
            },
        ],
        node-subnet-prod = [
            {
                range_name    = "pod-subnet-prod"
                ip_cidr_range = "${each.value.pod_subnet_prod}"
            },
            {
                range_name    = "svc-subnet-prod"
                ip_cidr_range = "${each.value.pod_subnet_dev}"
            },
        ] 
    }

    routes = []
}

#! Define primary and secondary subnets here
locals {
  networking_env = {

  app1 = {
    project_id       = data.terraform_remote_state.projects.outputs.module.project-factory["app1"].project_id
    region           = provider.google.region
    node_subnet_dev  = "10.0.0.0/29" #4 nodes
    pod_subnet_dev   = "10.0.4.0/22" #440 pods / 4 nodes
    svc_subnet_dev   = "10.0.0.128/25" #128 services / 4 nodes
    node_subnet_prod = "10.0.0.16/28" #12 nodes
    pod_subnet_prod  = "10.0.16.0/20" #1760 pods / 16 nodes
    svc_subnet_prod  = "10.0.2.0/23"  #512 services / 16 nodes
 }

  app2 = {
    project_id      = data.terraform_remote_state.projects.outputs.module.project-factory["app2"].project_id
    region          = provider.google.region
    node_subnet_dev  = "10.0.32.0/29" #4 nodes
    pod_subnet_dev   = "10.0.36.0/22" #440 pods / 4 nodes
    svc_subnet_dev   = "10.0.32.128/25" #128 services / 4 nodes
    node_subnet_prod = "10.0.32.16/28" #12 nodes
    pod_subnet_prod  = "10.0.48.0/20" #1760 pods / 16 nodes
    svc_subnet_prod  = "10.0.34.0/23"  #512 services / 16 nodes
  }

  app3 = {
    project_id  = data.terraform_remote_state.projects.outputs.module.project-factory["app3"].project_id
    region      = provider.google.region
    node_subnet_dev  = "10.0.64.0/29" #4 nodes
    pod_subnet_dev   = "10.0.68.0/22" #440 pods / 4 nodes
    svc_subnet_dev   = "10.0.64.128/25" #128 services / 4 nodes
    node_subnet_prod = "10.0.64.16/28" #12 nodes
    pod_subnet_prod  = "10.0.80.0/20" #1760 pods / 16 nodes
    svc_subnet_prod  = "10.0.66.0/23"  #512 services / 16 nodes
  }

  } 
}