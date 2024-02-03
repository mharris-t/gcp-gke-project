#! Fetch secrets or items created beforehand
data "google_secret_manager_secret" "billing" {
  secret_id = "my_org_billing_key"
}

data "google_secret_manager_secret" "org_id" {
  secret_id = "my_org_id"
}

data "google_service_account" "gov_svc_acc" {
  account_id = "governance" #governance@governance-12345.iam.gserviceaccount.com
}