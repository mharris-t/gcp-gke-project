output "app1_project_id" {
  value = module.project-factory["app1"].project_id
}

output "app2_project_id" {
  value = module.project-factory["app2"].project_id
}

output "app3_project_id" {
  value = module.project-factory["app3"].project_id
}

output "gov_svc_acc" {
  value = data.google_service_account.gov_svc_acc
}

output "app1_bast_svc_acc" {
  value = google_service_account.bastion_service_account["app1-bastion"]
}

output "app2_bast_svc_acc" {
  value = google_service_account.bastion_service_account["app1-bastion"]
}

output "app3_bast_svc_acc" {
  value = google_service_account.bastion_service_account["app1-bastion"]
}