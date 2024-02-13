resource "google_service_account" "service_account" {
  for_each     = toset(var.bastion_svc_accts)
  account_id   = "${each.key}-id"
  display_name = "Service Account for ${each.key}"
}

