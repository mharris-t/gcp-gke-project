module "project-factory" {
  source               = "terraform-google-modules/project-factory/google"
  version              = "~> 14.4"
  for_each             = local.project_env
  name                 = "gke-project-${each.key}"
  random_project_id    = false
  org_id               = "1234567890"
  usage_bucket_name    = "gke-project-${each.key}-usage-report-bucket"
  usage_bucket_prefix  = "gke-project/${each.key}/1/integration"
  billing_account      = "ABCDEF-ABCDEF-ABCDEF"
  activate_apis        = each.value.api_list

}


locals {
    project_env = {
        dev = {
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
        test = {
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
        prod = {
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