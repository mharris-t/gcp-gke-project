resource "google_service_account" "bastion_service_account" {
  for_each     = local.svc_accts
  account_id   = "${each.key}-id"
  display_name = "Service Account for ${each.key}"
}

locals {
  svc_accts = {
    app1-bastion = {
    project_id = module.project-factory["app1"].project_id
    }

    app2-bastion = {
    project_id = module.project-factory["app2"].project_id
    }
    app3-bastion = {
    project_id = module.project-factory["app3"].project_id
    }
  }
}

