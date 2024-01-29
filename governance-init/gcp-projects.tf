module "project-factory" {
  source               = "terraform-google-modules/project-factory/google"
  version              = "~> 14.4"
  for_each             = local.project_env
  name                 = "gke-project-${each.key}"
  random_project_id    = true
  org_id               = "1234567890"
  usage_bucket_name    = "gke-project-${each.key}-usage-report-bucket"
  usage_bucket_prefix  = "gke-project/${each.key}/1/integration"
  billing_account      = "ABCDEF-ABCDEF-ABCDEF"
  activate_apis        = each.value.api_list

}


locals {
    project_env = {
        dev = {
            availability_zones  = [1]
            enable_auto_scaling = false
            vnet_adress_space   = "10.0.0.0/8"
            k8s_subnet          = "10.1.0.0/16"
            nodepool_min_count  = 1
            nodepool_max_count  = 1
            nodepool_disk_size  = 10
            vm_size             = "Standard_DS1_v2"
            admin_username      = data.azurerm_key_vault_secret.aks_admin_username.value
            ssh_public_key      = data.azurerm_key_vault_secret.aks_ssh.value
        },
        test = {
            availability_zones  = [1]
            enable_auto_scaling = true
            vnet_adress_space   = "10.0.0.0/8"
            k8s_subnet          = "10.2.0.0/16"
            nodepool_min_count  = 1
            nodepool_max_count  = 2
            nodepool_disk_size  = 30
            vm_size             = "Standard_DS2_v2"
            admin_username      = data.azurerm_key_vault_secret.aks_admin_username.value
            ssh_public_key      = data.azurerm_key_vault_secret.aks_ssh.value
        }
        staging = {
            availability_zones  = [1,2,3]
            enable_auto_scaling = true
            vnet_adress_space   = "10.0.0.0/8"
            k8s_subnet          = "10.3.0.0/16"
            nodepool_min_count  = 1
            nodepool_max_count  = 4
            nodepool_disk_size  = 100
            vm_size             = "Standard_DS3_v2"
            admin_username      = data.azurerm_key_vault_secret.aks_admin_username.value
            ssh_public_key      = data.azurerm_key_vault_secret.aks_ssh.value
        }
    }
}