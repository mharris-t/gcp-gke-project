output "app1_gke_network" {
  value = module.vpc["app1"].network_name
}

output "app1_gke_subnets" {
  value = module.vpc["app1"].subnet_names
}

output "app2_gke_network" {
  value = module.vpc["app2"].network_name
}

output "app2_gke_subnets" {
  value = module.vpc["app2"].subnet_names
}

output "app3_gke_network" {
  value = module.vpc["app3"].network_name
}

output "app3_gke_subnets" {
  value = module.vpc["app3"].subnet_names
}

output "app1_bast_subnet" {
  value = module.vpc["app1"].subnets_self_links
}

output "app1_bast_subnet" {
  value = module.vpc["app2"].subnets_self_links
}

output "app1_bast_subnet" {
  value = module.vpc["app3"].subnets_self_links
}