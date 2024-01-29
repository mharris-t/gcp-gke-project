data "google_secret_manager_secret" "billing" {
  secret_id = "my_org_billing_key"
}