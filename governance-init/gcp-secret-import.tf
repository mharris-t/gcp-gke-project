data "google_secret_manager_secret" "billing" {
  secret_id = "my_org_billing_key"
}

data "google_secret_manager_secret" "org_id" {
  secret_id = "my_org_id"
}
