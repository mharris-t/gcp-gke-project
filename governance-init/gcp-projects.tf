module "folders" {
  source  = "terraform-google-modules/folders/google"
  version = "~> 4.0"

  parent  = "${data.google_secret_manager_secret.org_id.secret_id}"

  names   = [flatten([for env_key, value in local.project_env:[env_key]])]

  all_folder_admins = [
    "serviceAccount:${data.google_service_account.gov_svc_acc.email}",
  ]
}


module "project-factory" {
  source               = "terraform-google-modules/project-factory/google"
  version              = "~> 14.4"
  for_each             = local.project_env
  name                 = "gke-project-${each.key}"
  random_project_id    = false
  org_id               = data.google_secret_manager_secret.org_id.secret_id
  usage_bucket_name    = "gke-project-${each.key}-usage-report-bucket"
  usage_bucket_prefix  = "gke-project/${each.key}/1/integration"
  billing_account      = data.google_secret_manager_secret.billing.secret_id
  activate_apis        = each.value.api_list
  depends_on           = [ module.folders ]
}


locals {
    project_env = {
        app1 = {
            api_list  = ["cloudapis.googleapis.com",
                        "cloudbuild.googleapis.com",
                        "cloudfunctions.googleapis.com",
                        "container.googleapis.com",
                        "containerregistry.googleapis.com",
                        "iam.googleapis.com",
                        "iap.googleapis.com",
                        "servicenetworking.googleapis.com",
                        "storage-component.googleapis.com"  
                        ]
            
        },
        app2 = {
            api_list  = ["cloudapis.googleapis.com",
                        "cloudbuild.googleapis.com",
                        "cloudfunctions.googleapis.com",
                        "container.googleapis.com",
                        "containerregistry.googleapis.com",
                        "iam.googleapis.com",
                        "iap.googleapis.com",
                        "servicenetworking.googleapis.com",
                        "storage-component.googleapis.com"  
                        ]
        }
        app3 = {
            api_list  = ["dns.googleapis.com",
                        "cloudapis.googleapis.com",
                        "cloudbuild.googleapis.com",
                        "cloudfunctions.googleapis.com",
                        "container.googleapis.com",
                        "containerregistry.googleapis.com",
                        "iam.googleapis.com",
                        "iap.googleapis.com",
                        "servicenetworking.googleapis.com",
                        "storage-component.googleapis.com"]
        }
    }
}