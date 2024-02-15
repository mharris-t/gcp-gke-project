output "app1_gke_network" {
  value = module.gke-vpc["app1"].network_name
}

output "app1_gke_subnets" {
  value = module.gke-vpc["app1"].subnet_names
}

output "app2_gke_network" {
  value = module.gke-vpc["app2"].network_name
}

output "app2_gke_subnets" {
  value = module.gke-vpc["app2"].subnet_names
}

output "app3_gke_network" {
  value = module.gke-vpc["app3"].network_name
}

output "app3_gke_subnets" {
  value = module.gke-vpc["app3"].subnet_names
}

#! bastion subnet self links
output "app1_bast_subnet_self_links" {
  value = module.gke-vpc["app1"].subnets_self_links
}

output "app2_bast_subnet_self_links" {
  value = module.gke-vpc["app2"].subnets_self_links
}

output "app3_bast_subnet_self_links" {
  value = module.gke-vpc["app3"].subnets_self_links
}