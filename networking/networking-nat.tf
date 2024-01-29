resource "google_compute_router" "router" {
  for_each = local.nat_projects
  project  = data.terraform_remote_state.projects.outputs.module.project-factory["${each.key}"].project_id
  name     = "my-router-${each.key}"
  region   = module.vpc["${each.key}"].subnets.subnet_region
  network  = google_compute_network.net.id

  bgp {
    asn = (each.index * 10) + 64514 #dev 6514, test 64524, prod 6534
  }
  depends_on = [ module.vpc.subnet ]
}

resource "google_compute_router_nat" "nat" {
  for_each                           = local.nat_projects
  name                               = "my-nat-${each.key}"
  router                             = google_compute_router.router["${each.key}"].name
  region                             = google_compute_router.router["${each.key}"].region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
  depends_on = [ google_compute_router.router ]
}

locals {
  nat_projects = {
    app1 = {}
    app2 = {}
    app3 = {}
  }
}